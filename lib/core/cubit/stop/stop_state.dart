part of 'stop_cubit.dart';

abstract class StopState extends Equatable {
  const StopState();

  @override
  List<Object> get props => [];
}

class StopInitial extends StopState {}

class ArrivedStopSuccess extends StopState {}

class ArrivedStopFailed extends StopState {}

class DepartingStop extends StopState {}

class DepartedStopSuccess extends StopState {
  DepartedStopSuccess(this.stop);

  final StopModel stop;

  @override
  List<Object> get props => [
        stop.id,
      ];
}

class DepartedStopFailed extends StopState {}

class CloningStop extends StopState {}

class ClonedStopSuccess extends StopState {
  ClonedStopSuccess(this.stop);

  final StopModel stop;

  @override
  List<Object> get props => [
        stop.id,
      ];
}

class ClonedStopFailed extends StopState {}

class CancellingStop extends StopState {}

class CanceledStopSuccess extends StopState {
  CanceledStopSuccess(this.stop);

  final StopModel stop;

  @override
  List<Object> get props => [
        stop.id,
      ];
}

class CanceledStopFailed extends StopState {
  CanceledStopFailed(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class UndeliveringStop extends StopState {}

class UndeliveredStopSuccess extends StopState {
  UndeliveredStopSuccess(this.stop);

  final StopModel stop;

  @override
  List<Object> get props => [
        stop.id,
      ];
}

class UndeliveredStopFailed extends StopState {
  UndeliveredStopFailed(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}