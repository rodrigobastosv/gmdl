part of 'stop_cubit.dart';

abstract class StopState extends Equatable {
  const StopState();

  @override
  List<Object> get props => [];
}

class StopInitial extends StopState {}

class StopArriveLoad extends StopState {}

class StopArriveSuccess extends StopState {}

class StopArriveFailure extends StopState {
  StopArriveFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class StopDepartLoad extends StopState {}

class StopDepartSuccess extends StopState {
  StopDepartSuccess(this.stop);

  final StopModel stop;

  @override
  List<Object> get props => [
        stop.id,
      ];
}

class StopDepartFailure extends StopState {
  StopDepartFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class StopCloneLoad extends StopState {}

class StopCloneSuccess extends StopState {
  StopCloneSuccess(this.stop);

  final StopModel stop;

  @override
  List<Object> get props => [
        stop.id,
      ];
}

class StopCloneFailure extends StopState {
  StopCloneFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class StopCancelLoad extends StopState {}

class StopCancelSuccess extends StopState {
  StopCancelSuccess(this.stop);

  final StopModel stop;

  @override
  List<Object> get props => [
        stop.id,
      ];
}

class StopCancelFailure extends StopState {
  StopCancelFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class StopUndeliverLoad extends StopState {}

class StopUndeliverSuccess extends StopState {
  StopUndeliverSuccess(this.stop);

  final StopModel stop;

  @override
  List<Object> get props => [
        stop.id,
      ];
}

class StopUndeliverFailure extends StopState {
  StopUndeliverFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class StopRedeliverLoad extends StopState {}

class StopRedeliverSuccess extends StopState {
  StopRedeliverSuccess(this.newStop);

  final StopModel newStop;

  @override
  List<Object> get props => [
        newStop.id,
      ];
}

class StopRedeliverFailure extends StopState {
  StopRedeliverFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class StopServiceTimeUpdate extends StopState {
  StopServiceTimeUpdate(this.serviceTime);

  final int serviceTime;

  @override
  List<Object> get props => [
        serviceTime,
      ];
}