part of 'vehicle_bloc.dart';

abstract class VehicleEvent extends Equatable {
  const VehicleEvent();

  @override
  List<Object> get props => [];
}

class OnSetVehicleEvent extends VehicleEvent {
  final Vehiculo nuevoVehiculo;
  
  const OnSetVehicleEvent({required this.nuevoVehiculo});
}
