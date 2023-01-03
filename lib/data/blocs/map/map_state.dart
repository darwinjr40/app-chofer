part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowingUser;

  final bool showMyRoute;
  final bool showVehicleRoute;

  final Driver? driver;
  // * Esta variable polylines es una lista de rutas es un map para que el string sea
  // * el nombre de la ruta y el polyline sea la linea a dibujar

  final Map<String, Polyline> polylines;

  const MapState({
    this.isMapInitialized = false,
    this.isFollowingUser = true,
    this.showMyRoute = true,
    this.showVehicleRoute = true,
    Map<String, Polyline>? polylines,
    this.driver
  }) : polylines = polylines ?? const {};

  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    bool? showMyRoute,
    bool? showVehicleRoute,
    Map<String, Polyline>? polylines,
    Driver? driver,
  }) =>
      MapState(
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        isFollowingUser: isFollowingUser ?? this.isFollowingUser,
        showMyRoute: showMyRoute ?? this.showMyRoute,
        showVehicleRoute: showVehicleRoute ?? this.showVehicleRoute,
        polylines: polylines ?? this.polylines,
        driver: driver ?? this.driver,
      );

  @override
  List<Object?> get props => [
        isMapInitialized,
        isFollowingUser,
        polylines,
        showVehicleRoute,
        showMyRoute,
        driver,
      ];
}
