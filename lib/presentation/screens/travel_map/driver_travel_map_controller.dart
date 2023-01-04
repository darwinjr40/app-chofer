import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micros_app/data/models/models.dart';
import 'package:micros_app/presentation/utils/utils.dart';

class DriverTravelMapController {

  late BuildContext context;
  late GlobalKey<ScaffoldState> key =  GlobalKey();
  late Function refresh;

  Completer<GoogleMapController> _mapController = Completer();

  CameraPosition initialPosition = const CameraPosition(
      target: LatLng(1.2342774, -77.2645446),
      zoom: 14.0
  );

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  late Position _position;
  late StreamSubscription<Position> _positionStream;
  late BitmapDescriptor markerDriver;

  // GeofireProvider _geofireProvider;
  // AuthProvider _authProvider;
  // DriverProvider _driverProvider;
  // PushNotificationsProvider _pushNotificationsProvider;

  bool isConnect = false;
  // ProgressDialog _progressDialog;

  // StreamSubscription<DocumentSnapshot> _statusSuscription;
  // StreamSubscription<DocumentSnapshot> _driverInfoSuscription;

  late Driver driver;



  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    // _geofireProvider = new GeofireProvider();
    // _authProvider = new AuthProvider();
    // _driverProvider = new DriverProvider();
    // _pushNotificationsProvider = new PushNotificationsProvider();
    // _progressDialog = MyProgressDialog.createProgressDialog(context, 'Conectandose...');
    markerDriver = await createMarkerImageFromAsset('assets/img/taxi_icon.png');
    checkGPS();
    getDriverInfo();
  }

  void getDriverInfo() {
    // Stream<DocumentSnapshot> driverStream = _driverProvider.getByIdStream(_authProvider.getUser().uid);
    // _driverInfoSuscription = driverStream.listen((DocumentSnapshot document) {
    //   driver = Driver.fromJson(document.data());
      refresh();
    // });
  }

  void dispose() {
    // _positionStream?.cancel();
    // _statusSuscription?.cancel();
    // _driverInfoSuscription?.cancel();
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle('[{"elementType":"geometry","stylers":[{"color":"#212121"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#212121"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"color":"#757575"}]},{"featureType":"administrative.country","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"administrative.land_parcel","stylers":[{"visibility":"off"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#181818"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"poi.park","elementType":"labels.text.stroke","stylers":[{"color":"#1b1b1b"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#2c2c2c"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#8a8a8a"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#373737"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#3c3c3c"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#4e4e4e"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#3d3d3d"}]}]');
    // _mapController.complete(controller);
  }

  void saveLocation() async {
    // await _geofireProvider.create(
    //     _authProvider.getUser().uid,
    //     _position.latitude,
    //     _position.longitude
    // );
    // _progressDialog.hide();
  }

  void updateLocation() async  {
    // try {
    //   await _determinePosition();
    //   _position = await Geolocator.getLastKnownPosition();
    //   centerPosition();
    //   saveLocation();

    //   addMarker(
    //       'driver',
    //       _position.latitude,
    //       _position.longitude,
    //       'Tu posicion',
    //       '',
    //       markerDriver
    //   );
    //   refresh();

    //   _positionStream = Geolocator.getPositionStream(
    //       desiredAccuracy: LocationAccuracy.best,
    //       distanceFilter: 1
    //   ).listen((Position position) {
    //     _position = position;
    //     addMarker(
    //         'driver',
    //         _position.latitude,
    //         _position.longitude,
    //         'Tu posicion',
    //         '',
    //         markerDriver
    //     );
    //     animateCameraToPosition(_position.latitude, _position.longitude);
    //     saveLocation();
    //     refresh();
    //   });

    // } catch(error) {
    //   print('Error en la localizacion: $error');
    // }
  }

  void centerPosition() {
    // if (_position != null) {
    //   animateCameraToPosition(_position.latitude, _position.longitude);
    // }
    // else {
    //   SnackBar.showSnackbar(context, 'Activa el GPS para obtener la posicion');
    // }
  }

  void checkGPS() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationEnabled) {
      print('GPS ACTIVADO');
      updateLocation();
    }
    else {
      print('GPS DESACTIVADO');
      // bool locationGPS = await location.Location().requestService();
      // if (locationGPS) {
      //   updateLocation();
      //   print('ACTIVO EL GPS');
      // }
    }

  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future animateCameraToPosition(double latitude, double longitude) async {
    GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            bearing: 0,
            target: LatLng(latitude, longitude),
            zoom: 17
        )
    ));
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

}