import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micros_app/data/blocs/location/location_bloc.dart';
import 'package:micros_app/data/services/services.dart';
import 'package:micros_app/presentation/widgets/widgets.dart';
import 'package:provider/provider.dart';

class StatusView extends StatefulWidget {
  const StatusView({Key? key}) : super(key: key);

  @override
  State<StatusView> createState() => _StatusViewState();

  void stopTimer() {
    _StatusViewState().stopTimer();
  }
}

class _StatusViewState extends State<StatusView> {
  Duration duration = const Duration();
  Timer? timer;
  bool bigTimer = true;
  bool started = false;
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
  }

  void reset() {
    setState(() {
      duration = const Duration();
    });
  }

  void addTime() {
    const addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      duration = Duration(seconds: seconds);
    });
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() {
      timer?.cancel();
    });
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final service = Provider.of<AuthService>(context, listen: false);
    updateLocation(locationBloc, service, 0);


  }

  void startTimer({bool resets = true}) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final service = Provider.of<AuthService>(context, listen: false);

    if (resets) {
      reset();
    }
    updateLocation(locationBloc, service, 1);
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      addTime();
      if (duration.inSeconds % 5 == 0) {
        updateLocation(locationBloc, service, 1);
      }
    });
  }

  void updateLocation(LocationBloc locationBloc, AuthService service, int status) {
    if (locationBloc.state.lastKnownLocation != null) {
      final currentLat = locationBloc.state.lastKnownLocation!.latitude;
      final currentLong = locationBloc.state.lastKnownLocation!.longitude;
      debugPrint('${service.user.id}/${service.vehiculo.id}/$currentLat/$currentLong');
      DriversService.updateLocation(
        userId: '${service.user.id}',
        vehiculeId: '${service.vehiculo.id}',
        latitude: currentLat,
        longitud: currentLong,
        status: status,
      );
    }
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours.remainder(60));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Text(
      '$hours:$minutes:$seconds',
      style: const TextStyle(fontSize: 40),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRunning = timer == null ? false : timer!.isActive;
    final size = MediaQuery.of(context).size;
    final service = Provider.of<AuthService>(context, listen: false);
    final recorridoService =
        Provider.of<RecorridoService>(context, listen: false);

    return FadeInUp(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Text('data'),
            // Column(
            //   children: [
            //     isRunning ? buildTime() : const SizedBox(),
                // const SizedBox(height: 10),
                // isRunning
                //     ? MaterialButton(
                //         minWidth: size.width - 250,
                //         child: const Text(
                //           'Terminar Recorrido',
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontWeight: FontWeight.w700,
                //           ),
                //         ),
                //         color: Colors.black,
                //         elevation: 0,
                //         height: 50,
                //         shape: const StadiumBorder(),
                //         onPressed: () {
                //           recorridoService.setActive(false);
                //           DriversService.inService(
                //               vehicleId: service.vehiculo.id,
                //               userId: service.user.id,
                //               isLogin: 0,
                //               message: 'Terminar Recorrido');
                //           stopTimer();
                //         },
                //       )
                //     : const SizedBox(),
              // ],
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isRunning ? buildTime() : const SizedBox(),
                // buildTime(),
                // buildTime(),
                // buildTime(),
                isRunning
                    ? MaterialButton(
                        minWidth: size.width - 250,
                        child: const Text(
                          'Terminar Recorrido',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        color: Colors.black,
                        elevation: 0,
                        height: 50,
                        shape: const StadiumBorder(),
                        onPressed: () {
                          recorridoService.setActive(false);
                          DriversService.inService(
                              vehicleId: service.vehiculo.id,
                              userId: service.user.id,
                              isLogin: 0,
                              message: 'Terminar Recorrido');
                          stopTimer();
                        },
                      )
                    : MaterialButton(
                        minWidth: size.width - 250,
                        child: const Text(
                          'Empezar Recorrido',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        color: Colors.white,
                        elevation: 0,
                        height: 50,
                        shape: const StadiumBorder(),
                        onPressed: () {
                          recorridoService.setActive(true);
                          DriversService.inService(
                              vehicleId: service.vehiculo.id,
                              userId: service.user.id,
                              isLogin: 1,
                              message: 'Empezar Recorrido');
                          startTimer();
                        },
                      ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(),
                BtnLogOut(stopTimer: stopTimer),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
