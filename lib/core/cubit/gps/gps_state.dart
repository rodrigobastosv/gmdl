part of 'gps_cubit.dart';

abstract class GpsState extends Equatable {
  const GpsState();

  @override
  List<Object> get props => [];
}

class GpsInitial extends GpsState {}

class DriverPositionTrackingStarted extends GpsState {}

class NewPosition extends GpsState {
  NewPosition(this.position);

  final Position position;
}
