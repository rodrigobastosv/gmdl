import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gm_driver_lite/core/repository/initial_setup_repository.dart';

part 'initial_setup_state.dart';

class InitialSetupCubit extends Cubit<InitialSetupState> {
  InitialSetupCubit(
    this.repository,
  ) : super(InitialSetupInitial());

  final InitialSetupRepository repository;

  Future<void> validateServerName(String serverName) async {
    emit(InitialSetupInitial());
    try {
      final serverValidated = await repository.validateServerName(serverName);
      if (serverValidated) {
        emit(ServerValidationSuccess(serverName));
      } else {
        emit(ServerValidationFailed());
      }
    } on Exception {
      emit(ServerValidationFailed());
    }
  }
}
