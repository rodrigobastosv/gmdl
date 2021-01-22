part of 'initial_settings_cubit.dart';

abstract class InitialSettingsState extends Equatable {
  const InitialSettingsState();

  @override
  List<Object> get props => [];
}

class ServerValidationInitial extends InitialSettingsState {}

class ValidatingServer extends InitialSettingsState {}

class ServerValidationSuccess extends InitialSettingsState {
}

class ServerValidationFailed extends InitialSettingsState {
  ServerValidationFailed(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class ServerValidationLoading extends InitialSettingsState {}
