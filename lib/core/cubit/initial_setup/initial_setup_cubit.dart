// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

// Project imports:
import '../../hive/boxes.dart';
import '../../repository/initial_setup_repository.dart';

part 'initial_setup_state.dart';

class InitialSetupCubit extends Cubit<InitialSetupState> {
  InitialSetupCubit({
    this.repository,
    this.securityBox,
  }) : super(InitialSetupInitial());

  final InitialSetupRepository repository;
  final Box securityBox;

  Future<void> validateServerName(String serverName) async {
    emit(InitialSetupInitial());
    try {
      final serverValidated = await repository.validateServerName(serverName);
      if (serverValidated) {
        securityBox.put(SERVER_NAME, serverName);
        emit(ServerValidationSuccess());
      } else {
        emit(ServerValidationFailed());
      }
    } on Exception {
      emit(ServerValidationFailed());
    }
  }
}
