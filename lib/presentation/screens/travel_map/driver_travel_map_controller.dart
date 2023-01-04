import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micros_app/data/blocs/blocs.dart';
import 'package:micros_app/data/models/models.dart';
import 'package:micros_app/data/services/services.dart';
import 'package:micros_app/env.dart';
import 'package:micros_app/presentation/utils/utils.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';


class DriverTravelMapController{

  late BuildContext context;
  late GlobalKey<ScaffoldState> key =  GlobalKey();
  late Function refresh;

  final Completer<GoogleMapController> _mapController = Completer();

  CameraPosition initialPosition = const CameraPosition(
      target: LatLng(1.2342774, -77.2645446),
      zoom: 14.0
  );

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late Position _position;
  // late StreamSubscription<Position> _positionStream;
  late BitmapDescriptor markerDriver;
  late Set<Polyline> polylines;
  late List<LatLng> points;
  late LocationBloc locationBloc;
  late MapBloc mapBloc;
  late Timer timer;
  late Timer _timer;
  late int seconds = 0;
  late double mt = 0;
  late double km = 0;
  // GeofireProvider _geofireProvider;
  // AuthProvider _authProvider;
  // DriverProvider _driverProvider;
  // PushNotificationsProvider _pushNotificationsProvider;

  // bool isConnect = false;
  // ProgressDialog _progressDialog;

  // StreamSubscription<DocumentSnapshot> _statusSuscription;
  // StreamSubscription<DocumentSnapshot> _driverInfoSuscription;

  late Driver driver;
  late String _idTravel;
  late TravelInfo? travelInfo;
  late BitmapDescriptor fromMarker;
  late BitmapDescriptor toMarker;
  late bool isStartTravel;
  late double _distanceBetween;
  String currentStatus = 'INICIAR VIAJE';
  Color colorStatus = Colors.amber;


  //constructor
  DriverTravelMapController(){
    polylines = {};
    points = [];
    _idTravel ='';
    isStartTravel = false;
    travelInfo = null;
  }

  Future init(BuildContext context, Function refresh) async {
    try {
      this.context = context;
      this.refresh = refresh;
      locationBloc = BlocProvider.of<LocationBloc>(context);
      mapBloc = BlocProvider.of<MapBloc>(context);
      _idTravel = ModalRoute.of(context)?.settings.arguments as String;
      fromMarker = await createMarkerImageFromAsset('assets/img/map_pin_red.png');
      toMarker = await createMarkerImageFromAsset('assets/img/map_pin_blue.png'); 
      getTravelInfo();
      initTimer();
    } catch (error) {
      debugPrint('ERROR <DriverTravelMapController> INIT $error');
    }
    // _geofireProvider = new GeofireProvider();
    // _authProvider = new AuthProvider();
    // _driverProvider = new DriverProvider();
    // _pushNotificationsProvider = new PushNotificationsProvider();
    // _progressDialog = MyProgressDialog.createProgressDialog(context, 'Conectandose...');
    // markerDriver = await createMarkerImageFromAsset('assets/img/taxi_icon.png');
    // checkGPS();
    // getDriverInfo();
  }

  void isCloseToPickupPosition(LatLng from, LatLng to) {
    _distanceBetween = Geolocator.distanceBetween(
        from.latitude,
        from.longitude,
        to.latitude,
        to.longitude
    );
    print('------ DISTANCE: $_distanceBetween--------');
  }

  void updateStatus () {
    if (travelInfo != null) {
      if (travelInfo!.status == 'accepted') {
        startTravel();
      } else if (travelInfo!.status == 'started') {
        finishTravel();
      }
    } else {
      debugPrint("ERROR -> travelinfo  = null");
    }
  }
  Future<double> calculatePrice() async {
    if (seconds < 60) {
      seconds = 60;
    }
    if (km == 0) {
      km = 0.1;
    }
    debugPrint("=======MIN TOTALES==============");
    int min = seconds ~/ 60;
    debugPrint(min.toString());
    debugPrint("=======KM TOTALES==============");
    debugPrint(km.toString());
    double priceMin = min * Price.min;
    double pricetk = km * Price.km;
    double total = priceMin + pricetk;
    if (total < Price.minValue) {  
      total =  Price.minValue;      
    }
    return total;
  }
  void startTimer(){
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) { 
      seconds = timer.tick;
      refresh();
    });
  }
  void startTravel() async {
    if (_distanceBetween > 300) {
      Snackbar.showSnackbar(context, 'DEBES ESTAR CERCA A LA POSICION DEL CLIENTE');
    } else {
      Map<String, String> data = {
        'status': 'started'
      };
      await TravelInfoService.update(data, _idTravel);
      travelInfo!.status = 'started';
      currentStatus = 'FINALIZAR VIAJE';
      colorStatus = Colors.red;
      polylines = {};
      points = [];
      markers.remove(markers['from']);
      addSimpleMarker(
          'to',
          travelInfo!.toLat,
          travelInfo!.toLng,
          'Destino',
          '',
          toMarker
      );
      LatLng from =  locationBloc.state.lastKnownLocation!;
      LatLng to =  LatLng(travelInfo!.toLat, travelInfo!.toLng);
      setPolylines(from, to);
      startTimer();
    }
    refresh();
  }

  void finishTravel() async {
    _timer.cancel();
    double total = await calculatePrice();
    if (travelInfo != null) {
      Map<String, String> data = {
        'status': 'finished'
      };
      await TravelInfoService.update(data, _idTravel);
      travelInfo!.status = 'finished';
      // Navigator.pushNamedAndRemoveUntil(context, "driver/travel/calification", (route) => false);
      Navigator.pushNamed(context, "driver/travel/calification");
      refresh();      
    }
  }


  void getTravelInfo() async{        
    int n = 3;
    while(n > 0 && travelInfo == null){
      travelInfo = await TravelInfoService.getbyId(_idTravel);
      n = n - 1;
      debugPrint('getTravelInfo--------------------$n');
    }
    debugPrint('NISE--------------------$travelInfo');
    if (travelInfo != null) {
      LatLng from = locationBloc.state.lastKnownLocation!;
      LatLng to = LatLng(travelInfo!.fromLat, travelInfo!.fromLng);
      setPolylines(from, to);
      refresh();
    }
    // Stream<DocumentSnapshot> driverStream = _driverProvider.getByIdStream(_authProvider.getUser().uid);
    // _driverInfoSuscription = driverStream.listen((DocumentSnapshot document) {
    //   driver = Driver.fromJson(document.data());
    // });
  }


  Future<void> setPolylines(LatLng from, LatLng to ) async {
    PointLatLng pointFromLatLng = PointLatLng(from.latitude, from.longitude);
    PointLatLng pointToLatLng = PointLatLng(to.latitude, to.longitude);

    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
        googleApiKey,
        pointFromLatLng,
        pointToLatLng
    );

    for (PointLatLng point in result.points) {
      points.add(LatLng(point.latitude, point.longitude));
    }

    Polyline polyline = Polyline(
      polylineId: const PolylineId('poly'),
      color: Colors.amber,
      points: points,
      width: 6
    );
    polylines.add(polyline);
    // mapBloc.add(onUpdatePolylinesEvent({"ruta":polyline}));
    addSimpleMarker('from',to.latitude, to.longitude, 'Recoger aqui', '', fromMarker);
    // addMarker('to', mapBloc.state.toLatLng!.latitude, mapBloc.state.toLatLng!.longitude, 'Destino', '', toMarker);
    refresh();
  }
  
  void dispose() {
    timer.cancel();
    _timer.cancel();
    // _positionStream?.cancel();
    // _statusSuscription?.cancel();
    // _driverInfoSuscription?.cancel();
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle('[{"elementType":"geometry","stylers":[{"color":"#212121"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#212121"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"color":"#757575"}]},{"featureType":"administrative.country","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"administrative.land_parcel","stylers":[{"visibility":"off"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#181818"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"poi.park","elementType":"labels.text.stroke","stylers":[{"color":"#1b1b1b"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#2c2c2c"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#8a8a8a"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#373737"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#3c3c3c"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#4e4e4e"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#3d3d3d"}]}]');
    // _mapController.complete(controller);
  }


  Future<BitmapDescriptor> createMarkerImageFromAsset(String path) async {
    ImageConfiguration configuration = const ImageConfiguration();
    BitmapDescriptor bitmapDescriptor =
    await BitmapDescriptor.fromAssetImage(configuration, path);
    return bitmapDescriptor;
  }

  void addMarker(
      String markerId,
      double lat,
      double lng,
      String title,
      String content,
      BitmapDescriptor iconMarker
      ) {

    MarkerId id = MarkerId(markerId);
    Marker marker = Marker(
        markerId: id,
        icon: iconMarker,
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: title, snippet: content),
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: const Offset(0.5, 0.5),
        rotation: _position.heading
    );

    markers[id] = marker;

  }
  void addSimpleMarker(
      String markerId,
      double lat,
      double lng,
      String title,
      String content,
      BitmapDescriptor iconMarker
      ) {

    MarkerId id = MarkerId(markerId);
    Marker marker = Marker(
        markerId: id,
        icon: iconMarker,
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: title, snippet: content),
    );

    markers[id] = marker;

  }
  

  void initTimer() async{
    try {
      timer = Timer.periodic(const Duration(seconds: 4), (timer) async {
        if (travelInfo != null) {
          if (travelInfo!.status == 'started') {
            if (locationBloc.state.myLocationHistory.isNotEmpty) {
              final n = locationBloc.state.myLocationHistory.length;
              final punto = locationBloc.state.myLocationHistory[n-1];
              mt = mt + Geolocator.distanceBetween(
                locationBloc.state.lastKnownLocation!.latitude,
                locationBloc.state.lastKnownLocation!.longitude,
                punto.latitude,
                punto.longitude,
              );
              debugPrint(mt.toString());
              km = mt / 1000;
            }
          }
          LatLng from =  locationBloc.state.lastKnownLocation!;
          LatLng to =  LatLng(travelInfo!.fromLat, travelInfo!.fromLng);
          isCloseToPickupPosition(from, to);  
          refresh();
        }
        debugPrint(mt.toString());

      });
    } catch (error) {
      debugPrint('TRY ERROR <DriverTravelMap> startTimer: $error');
    }
  }

}