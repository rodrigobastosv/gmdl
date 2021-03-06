part of 'map_cubit.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class MapUpdateDriverPosition extends MapState {
  MapUpdateDriverPosition(this.position);

  final Position position;

  @override
  List<Object> get props => [
        position.latitude,
        position.longitude,
      ];
}

class MapShowStop extends MapState {
  MapShowStop(this.stop);

  final StopModel stop;

  @override
  List<Object> get props => [
        stop,
      ];
}

class RouteUpdated extends MapState {
  @override
  List<Object> get props => [];
}

class RouteUpdatedDueOptimization extends MapState {
  @override
  List<Object> get props => [];
}
