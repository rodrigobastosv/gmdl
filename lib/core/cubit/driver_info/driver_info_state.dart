part of 'driver_info_cubit.dart';

abstract class DriverInfoState extends Equatable {
  const DriverInfoState();

  @override
  List<Object> get props => [];
}

class DriverInfoInitial extends DriverInfoState {}

class DriverInfoSuccess extends DriverInfoState {}

class DriverInfoFailed extends DriverInfoState {}

class DriverInfoLoading extends DriverInfoState {}
