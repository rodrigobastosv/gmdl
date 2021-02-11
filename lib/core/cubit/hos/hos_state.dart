part of 'hos_cubit.dart';

abstract class HosState extends Equatable {
  const HosState();

  @override
  List<Object> get props => [];
}

class HosInitial extends HosState {}

class HosLunchStartSuccess extends HosState {}

class HosLunchStartFailure extends HosState {
  HosLunchStartFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class HosLunchEndSuccess extends HosState {}

class HosLunchEndFailure extends HosState {
  HosLunchEndFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class HosLunchTimeMinutePass extends HosState {
  HosLunchTimeMinutePass(this.minutesPassed);

  final int minutesPassed;

  @override
  List<Object> get props => [
        minutesPassed,
      ];
}
