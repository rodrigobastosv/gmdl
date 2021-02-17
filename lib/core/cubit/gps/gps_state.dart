part of 'gps_cubit.dart';

abstract class GpsState extends Equatable {
  const GpsState();

  @override
  List<Object> get props => [];
}

class GpsInitial extends GpsState {}

class GpsDriverPositionTrackingStartSuccess extends GpsState {}

class GpsNewPosition extends GpsState {
  GpsNewPosition(this.position);

  final Position position;

  @override
  List<Object> get props => [
        position.latitude,
        position.longitude,
      ];
}
