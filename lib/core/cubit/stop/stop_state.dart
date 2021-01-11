part of 'stop_cubit.dart';

abstract class StopState extends Equatable {
  const StopState();

  @override
  List<Object> get props => [];
}

class StopInitial extends StopState {}

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
