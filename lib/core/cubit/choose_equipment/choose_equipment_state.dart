part of 'choose_equipment_cubit.dart';

abstract class ChooseEquipmentState extends Equatable {
  const ChooseEquipmentState();

  @override
  List<Object> get props => [];
}

class ChooseEquipmentInitial extends ChooseEquipmentState {}

class EquipmentFound extends ChooseEquipmentState {}

class EquipmentNotFound extends ChooseEquipmentState {
  EquipmentNotFound(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
    errorMessage,
  ];
}

class EquipmentFailed extends ChooseEquipmentState {
  EquipmentFailed(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
    errorMessage,
  ];
}

class LoadingEquipment extends ChooseEquipmentState {}
