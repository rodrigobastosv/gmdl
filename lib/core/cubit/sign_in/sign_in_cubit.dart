import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gm_driver_lite/core/entity/dto/login_result_dto.dart';
import 'package:gm_driver_lite/core/exception/exceptions.dart';
import 'package:gm_driver_lite/core/repository/sign_in_repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(
    this.repository,
  )   : assert(repository != null),
        super(SignInInitial());

  final SignInRepository repository;

  Future<void> signInUser({
    String serverName,
    String username,
    String password,
  }) async {
    emit(UserSigningLoading());
    try {
      final signInResponse = await repository.signInUser(
        username: username,
        password: password,
      );
      final loginResult = LoginResultDTO.fromJson(signInResponse);
      emit(UserSignedSuccess(loginResult));
    } on SignInException {
      emit(UserSigningFailed());
    }
  }
}
