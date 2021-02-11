part of 'choose_redeliver_code_cubit.dart';

abstract class ChooseRedeliverCodeState extends Equatable {
  const ChooseRedeliverCodeState();

  @override
  List<Object> get props => [];
}

class ChooseRedeliverCodeInitial extends ChooseRedeliverCodeState {}

class ChooseRedeliverCodePickCode extends ChooseRedeliverCodeState {
  ChooseRedeliverCodePickCode(this.redeliverableCodeModel);

  final UndeliverableCodeModel redeliverableCodeModel;

  @override
  List<Object> get props => [
        redeliverableCodeModel?.id,
      ];
}
