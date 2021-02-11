part of 'choose_undeliverable_code_cubit.dart';

abstract class ChooseUndeliverableCodeState extends Equatable {
  const ChooseUndeliverableCodeState();

  @override
  List<Object> get props => [];
}

class ChooseUndeliverableCodeInitial extends ChooseUndeliverableCodeState {}

class ChooseUndeliverableCodePickCode extends ChooseUndeliverableCodeState {
  ChooseUndeliverableCodePickCode(this.undeliverableCodeModel);

  final UndeliverableCodeModel undeliverableCodeModel;

  @override
  List<Object> get props => [
        undeliverableCodeModel?.id,
      ];
}
