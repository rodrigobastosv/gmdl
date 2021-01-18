import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../entity/model/models.dart';

part 'choose_undeliverable_code_state.dart';

class ChooseUndeliverableCodeCubit extends Cubit<ChooseUndeliverableCodeState> {
  ChooseUndeliverableCodeCubit() : super(ChooseUndeliverableCodeInitial());

  UndeliverableCodeModel pickedUndeliverableCode;

  bool get hasUndeliverableCodePicked => pickedUndeliverableCode != null;

  void pickUndeliverableCode(UndeliverableCodeModel undeliverableCodeModel) {
    pickedUndeliverableCode = undeliverableCodeModel;
    emit(UndeliverableCodePicked(undeliverableCodeModel));
  }

  void unpickUndeliverableCode(UndeliverableCodeModel undeliverableCodeModel) {
    pickedUndeliverableCode = null;
    emit(UndeliverableCodePicked(null));
  }
}
