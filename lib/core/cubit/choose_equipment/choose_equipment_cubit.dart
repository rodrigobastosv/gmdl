import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../exception/exceptions.dart';
import '../../repository/repositories.dart';

part 'choose_equipment_state.dart';

class ChooseEquipmentCubit extends Cubit<ChooseEquipmentState> {
  ChooseEquipmentCubit(this._repository)
      : assert(_repository != null),
        super(ChooseEquipmentInitial());

  final EquipmentRepository _repository;

  Future<void> getEquipmentInfo(String equipmentKey) async {
    try {
      emit(LoadingEquipment());
      await _repository.getEquipment(equipmentKey);
      emit(EquipmentFound());
    } on EquipmentNotFoundException catch (e) {
      emit(EquipmentNotFound(e.errorMessage));
    } on GMServerException catch (e) {
      emit(EquipmentFailed(e.errorMessage));
    }
  }
}
