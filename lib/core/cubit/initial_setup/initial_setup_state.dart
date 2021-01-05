part of 'initial_setup_cubit.dart';

abstract class InitialSetupState extends Equatable {
  const InitialSetupState();

  @override
  List<Object> get props => [];
}

class InitialSetupInitial extends InitialSetupState {}

class ServerValidationSuccess extends InitialSetupState {
  ServerValidationSuccess(this.serverName);

  final String serverName;

  @override
  List<Object> get props => [serverName];
}

class ServerValidationFailed extends InitialSetupState {}

class ServerValidationLoading extends InitialSetupState {}
