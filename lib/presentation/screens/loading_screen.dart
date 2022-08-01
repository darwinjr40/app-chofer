import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micros_app/data/blocs/blocs.dart';
import 'package:micros_app/data/services/services.dart';
import 'package:micros_app/presentation/screens/gps_access_screen.dart';
import 'package:micros_app/presentation/screens/map_screen.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<AuthService>(context);
    final mapbloc = BlocProvider.of<MapBloc>(context, listen: false);
    // final locationBloc = BlocProvider.of<LocationBloc>(context, listen: false);

    return Scaffold(body: BlocBuilder<GpsBloc, GpsState>(
      builder: (context, state) {
        if (state.isAllGranted) {
          if (!service.isLoading ) {
            // if (locationBloc.state.lastKnownLocation != null) {
            //    debugPrint('se actualizo routas true');
            //   // final currentLat = locationBloc.state.lastKnownLocation!.latitude;
            //   // final currentLong = locationBloc.state.lastKnownLocation!.longitude;
            //   locationBloc.add(const OnUpdateLocationHistoryEvent([]));
            // }
            // if (service.vehiculo.routes) {
              
            // }
            mapbloc.add(OnAddPolylinesEvent(service.vehiculo.routes!));
            debugPrint('se actualizo routas--Loading');
          }
          return const MapScreen();
        } else {
          return const GpsAccessScreen();
        }
        // return state.isAllGranted ? const MapScreen() : const GpsAccessScreen();
      },
    ));
  }
}
