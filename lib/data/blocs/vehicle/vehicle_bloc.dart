import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:micros_app/data/models/models.dart';

part 'vehicle_event.dart';
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  VehicleBloc() : super(const VehicleState()) {
    on<VehicleEvent>((event, emit) {});
    
    on<OnSetVehicleEvent>((event, emit) {
      emit(state.copyWith(vehicleNew: event.nuevoVehiculo));
      debugPrint(state.vehicle!.id.toString());
    });
  }
}
