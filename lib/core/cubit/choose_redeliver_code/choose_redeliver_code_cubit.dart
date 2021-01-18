import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entity/model/models.dart';

part 'choose_redeliver_code_state.dart';

class ChooseRedeliverCodeCubit extends Cubit<ChooseRedeliverCodeState> {
  ChooseRedeliverCodeCubit() : super(ChooseRedeliverCodeInitial());

  UndeliverableCodeModel pickedRedeliverableCode;

  bool get hasRedeliverableCodePicked => pickedRedeliverableCode != null;

  void pickRedeliverCode(UndeliverableCodeModel redeliverableCode) {
    pickedRedeliverableCode = redeliverableCode;
    emit(RedeliverCodePicked(redeliverableCode));
  }

  void unpickRedeliverCode(UndeliverableCodeModel redeliverableCode) {
    pickedRedeliverableCode = null;
    emit(RedeliverCodePicked(null));
  }
}
