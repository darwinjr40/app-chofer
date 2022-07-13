part of 'vehicle_bloc.dart';


 class VehicleState extends Equatable {
  final Vehiculo? vehicle;

  const VehicleState({ this.vehicle});

  VehicleState copyWith({
    Vehiculo? vehicleNew,
  }) =>
      VehicleState(vehicle: vehicleNew ?? vehicle);
  
  @override
  List<Object?> get props => [vehicle];
}
