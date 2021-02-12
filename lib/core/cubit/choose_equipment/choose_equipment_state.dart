part of 'choose_equipment_cubit.dart';

abstract class ChooseEquipmentState extends Equatable {
  const ChooseEquipmentState();

  @override
  List<Object> get props => [];
}

class ChooseEquipmentInitial extends ChooseEquipmentState {}

class ChooseEquipmentFound extends ChooseEquipmentState {}

class ChooseEquipmentNotFound extends ChooseEquipmentState {
  ChooseEquipmentNotFound(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class ChooseEquipmentFailure extends ChooseEquipmentState {
  ChooseEquipmentFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class ChooseEquipmentLoad extends ChooseEquipmentState {}
