import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micros_app/data/blocs/location/location_bloc.dart';
import 'package:micros_app/data/services/auth_service.dart';
import 'package:micros_app/data/services/services.dart';
import 'package:provider/provider.dart';

class StatusView extends StatefulWidget {
  const StatusView({Key? key}) : super(key: key);

  @override
  State<StatusView> createState() => _StatusViewState();
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
  }

  void startTimer({bool resets = true}) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    if (resets) {
      reset();
    }
    if (locationBloc.state.lastKnownLocation != null) {
      final currentLat = locationBloc.state.lastKnownLocation!.latitude;
      final currentLong = locationBloc.state.lastKnownLocation!.longitude;
      DriversService.updateLocation(
        userId: '1',
        vehiculeId: '1',
        latitude: currentLat,
        longitud: currentLong,
      );
    }
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      addTime();
      if (duration.inSeconds % 5 == 0) {
        if (locationBloc.state.lastKnownLocation != null) {
          final currentLat = locationBloc.state.lastKnownLocation!.latitude;
          final currentLong = locationBloc.state.lastKnownLocation!.longitude;
          DriversService.updateLocation(
            userId: '1',
            vehiculeId: '1',
            latitude: currentLat,
            longitud: currentLong,
          );
        }
      }
    });
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

    return FadeInUp(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isRunning ? buildTime() : const SizedBox(),
            const SizedBox(height: 10),
            !isRunning
                ? MaterialButton(
                    minWidth: size.width - 100,
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
                      startTimer();
                    },
                  )
                : const SizedBox(),
            isRunning
                ? MaterialButton(
                    minWidth: size.width - 100,
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
                      stopTimer();
                    },
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
