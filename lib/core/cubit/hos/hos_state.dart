part of 'hos_cubit.dart';

abstract class HosState extends Equatable {
  const HosState();

  @override
  List<Object> get props => [];
}

class HosInitial extends HosState {}

class LunchStarted extends HosState {}

class LunchEnded extends HosState {}

class LunchStartFailed extends HosState {
  LunchStartFailed(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class LunchEndFailed extends HosState {
  LunchEndFailed(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class LunchTimeMinutePassed extends HosState {
  LunchTimeMinutePassed(this.minutesPassed);

  final int minutesPassed;

  @override
  List<Object> get props => [
        minutesPassed,
      ];
}
