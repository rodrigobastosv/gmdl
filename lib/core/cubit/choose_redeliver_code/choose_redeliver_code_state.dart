part of 'choose_redeliver_code_cubit.dart';

abstract class ChooseRedeliverCodeState extends Equatable {
  const ChooseRedeliverCodeState();

  @override
  List<Object> get props => [];
}

class ChooseRedeliverCodeInitial extends ChooseRedeliverCodeState {}

class RedeliverCodePicked extends ChooseRedeliverCodeState {
  RedeliverCodePicked(this.redeliverableCodeModel);

  final UndeliverableCodeModel redeliverableCodeModel;

  @override
  List<Object> get props => [
        redeliverableCodeModel?.id,
      ];
}
