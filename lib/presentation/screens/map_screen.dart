import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micros_app/data/blocs/blocs.dart';
import 'package:micros_app/data/services/services.dart';
import 'package:micros_app/presentation/views/views.dart';
import 'package:micros_app/presentation/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  
  late LocationBloc locationBloc;
  late MapBloc mapBloc;
  late AuthService authService;
  
  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    mapBloc = BlocProvider.of<MapBloc>(context);
    authService = Provider.of<AuthService>(context, listen: false);
    // locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
    mapBloc.loadDriver(authService.user.id, authService.vehiculo.id);      
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
                      bottom: 24,
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
