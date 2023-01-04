import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micros_app/data/blocs/blocs.dart';
import 'package:micros_app/data/services/services.dart';
import 'package:micros_app/presentation/screens/travel_map/driver_travel_map_controller.dart';
import 'package:micros_app/presentation/views/views.dart';
import 'package:micros_app/presentation/widgets/widgets.dart';
import 'package:provider/provider.dart';


class DriverTravelMapPage extends StatefulWidget {
  const DriverTravelMapPage({Key? key}) : super(key: key);

  @override
  DriverTravelMapPageState createState() => DriverTravelMapPageState();
}

class DriverTravelMapPageState extends State<DriverTravelMapPage> {

  final DriverTravelMapController _con = DriverTravelMapController();

late LocationBloc locationBloc;
  late MapBloc mapBloc;
  late AuthService authService;
  
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
    locationBloc = BlocProvider.of<LocationBloc>(context);
    mapBloc = BlocProvider.of<MapBloc>(context);
    authService = Provider.of<AuthService>(context, listen: false);
    // locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
    // mapBloc.loadDriver(authService.user.id, authService.vehiculo.id);      
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const statusView = StatusView();
    return Scaffold(
      key: _con.key,
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          if (locationState.lastKnownLocation == null) {
            return const Center(
              child: Text('Espere por favor...'),
            );
          }
          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {
              Map<String, Polyline> polylines = Map.from(mapState.polylines);
              if (mapState.showMyRoute) {
                polylines.removeWhere((key, value) => key == 'myRoute');
              }
              // if (mapState.showVehicleRoute) {
              //   polylines.removeWhere((key, value) => key == 'vuelta');
              // } else {
              //   polylines.removeWhere((key, value) => key == 'ida');
              // }

              return SingleChildScrollView(
                child: Stack(
                  children: [
                    MapView(
                      initialLocation: locationState.lastKnownLocation!,
                      polylines: polylines.values.toSet(),
                      markers: Set<Marker>.of(_con.markers.values),
                    ),
                    // const Positioned(
                    //   bottom: 24,
                    //   left: 10,
                    //   child: statusView,
                    // ),
                    SafeArea(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buttonUserInfo(),
                              // Column(
                              //   children: [
                                  _cardKmInfo('0'),
                                  _cardMinInfo('0')
                              //   ],
                              // ),
                            ],
                          ),
                          // Expanded(child: Container()),
                           
                          //  _buttonStatus(),
                          
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 5,
                      child: _buttonStatus(),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              BtnFollowUser(),              
              BtnToogleUserRoute(),
              BtnCurrentLocation(),
            ],
          ),
        ],
      ),
    );
  }

    Widget _buttonUserInfo() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          shape: const CircleBorder(),
          color: Colors.white,
          elevation: 4.0,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.person,
              color: Colors.grey[600],
              size: 20,
            ),
          ),
        ),
      ),
    );
  }


    Widget _cardKmInfo(String km) {
    return SafeArea(
        child: Container(
          width: 110,
          margin: const EdgeInsets.only(top: 10),
          // ignore: prefer_const_constructors
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: const BorderRadius.all(Radius.circular(20))
          ),
          child: Text(
            '$km km',
            maxLines: 1,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        )
    );
  }


  Widget _cardMinInfo(String min) {
    return SafeArea(
        child: Container(
          width: 110,
          margin: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Text(
            '$min seg',
            maxLines: 1,
            textAlign: TextAlign.center,
             style: const TextStyle(color: Colors.white),
          ),
        )
    );
  }

  Widget _buttonStatus() {
    return Container(
      height: 50,
      width: 200,
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
      child: BtnSolicit(
        onPressed: () {},
        text: 'INICIAR VIAJE',
        color: Colors.black,
        textColor: Colors.white,
      ),
    );
  }
  void refresh() {
    setState(() {});
  }
}
