part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MapEvent {
  final GoogleMapController controller;

  const OnMapInitializedEvent(this.controller);
}

class OnStopFollowingUserMap extends MapEvent {}

class OnStartFollowingUserMap extends MapEvent {}

class UpdateUserPolylineEvent extends MapEvent {
  final List<LatLng> userLocations;

  const UpdateUserPolylineEvent(this.userLocations);
}

class OnToogleUserRoute extends MapEvent {}

class OnIncrementarCounterEvent extends MapEvent {
  final int userInput;

  const OnIncrementarCounterEvent(this.userInput);
}

class OnAddPolylinesEvent extends MapEvent {
  final Map<String, Polyline> aux;

  const OnAddPolylinesEvent(this.aux);
}
