import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micros_app/data/blocs/blocs.dart';
import 'package:micros_app/presentation/views/views.dart';
import 'package:micros_app/presentation/widgets/widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    // locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
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
              if (!mapState.showMyRoute) {
                polylines.removeWhere((key, value) => key == 'myRoute');
              }
              if (mapState.showVehicleRoute) {
                polylines.removeWhere((key, value) => key == 'vuelta');
              } else {
                polylines.removeWhere((key, value) => key == 'ida');
              }

              return SingleChildScrollView(
                child: Stack(
                  children: [
                    MapView(
                      initialLocation: locationState.lastKnownLocation!,
                      polylines: polylines.values.toSet(),
                    ),
                    const Positioned(
                      bottom: 30,
                      left: 10,
                      // child: IconButton(
                      //   icon: const Icon(Icons.send),
                      //   onPressed: () {
                      //     if (locationState.lastKnownLocation == null) return;
                      //     final currentLat =
                      //         locationState.lastKnownLocation!.latitude;
                      //     final currentLong =
                      //         locationState.lastKnownLocation!.longitude;
                      //     print('timer  $currentLat , $currentLong');
                      //   },
                      // ),
                      // child: statusView,
                      child: statusView,
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
              // BtnLogOut(stopTimer:  statusView.stopTimer()),
               
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              BtnFollowUser(),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              BtnChangeRoute(),
              BtnToogleUserRoute(),
              BtnCurrentLocation(),
            ],
          ),
        ],
      ),
    );
  }
}
