part of 'choose_cancel_code_cubit.dart';

abstract class ChooseCancelCodeState extends Equatable {
  const ChooseCancelCodeState();

  @override
  List<Object> get props => [];
}

class ChooseCancelCodeInitial extends ChooseCancelCodeState {}

class ChooseCancelCodePickCode extends ChooseCancelCodeState {
  ChooseCancelCodePickCode(this.cancelCode);

  final CancelCodeModel cancelCode;

  @override
  List<Object> get props => [
        cancelCode?.id,
      ];
}
