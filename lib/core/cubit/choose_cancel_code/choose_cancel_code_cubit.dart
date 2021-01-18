import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entity/model/cancel_code_model.dart';

part 'choose_cancel_code_state.dart';

class ChooseCancelCodeCubit extends Cubit<ChooseCancelCodeState> {
  ChooseCancelCodeCubit() : super(ChooseCancelCodeInitial());

  CancelCodeModel pickedCancelCode;

  bool get hasCancelCodePicked => pickedCancelCode != null;

  void pickCancelCode(CancelCodeModel cancelCode) {
    pickedCancelCode = cancelCode;
    emit(CancelCodePicked(cancelCode));
  }

  void unpickCancelCode(CancelCodeModel cancelCode) {
    pickedCancelCode = null;
    emit(CancelCodePicked(null));
  }
}
