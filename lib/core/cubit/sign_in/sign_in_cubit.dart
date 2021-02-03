import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../utils/utils.dart';
import 'package:hive/hive.dart';

import '../../entity/dto/login_result_dto.dart';
import '../../exception/exceptions.dart';
import '../../global/hive.dart';
import '../../repository/sign_in_repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    @required SignInRepository repository,
    @required this.globalBox,
  })  : assert(repository != null),
        assert(globalBox != null),
        _repository = repository,
        super(SignInInitial());

  final SignInRepository _repository;
  final Box globalBox;

  Future<void> signInUser({
    String serverName,
    String username,
    String password,
  }) async {
    emit(UserSigningLoading());
    try {
      final signInResponse = await _repository.signInUser(
        username: username,
        password: password,
      );
      final loginResult = LoginResultDTO.fromJson(username, signInResponse);
      globalBox.put(USERNAME, username);
      globalBox.put(PASSWORD, encodeString(password));
      globalBox.put(TOKEN, loginResult.jSessionId);
      emit(UserSignedSuccess(loginResult));
    } on SignInException catch (e) {
      emit(UserSigningFailed(e.errorMessage));
    }
  }
}
