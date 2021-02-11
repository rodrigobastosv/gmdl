import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../entity/dto/login_result_dto.dart';
import '../../exception/exceptions.dart';
import '../../global/hive.dart';
import '../../repository/sign_in_repository.dart';
import '../../utils/utils.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    @required SignInRepository repository,
    @required Box globalBox,
  })  : assert(repository != null),
        assert(globalBox != null),
        _repository = repository,
        _globalBox = globalBox,
        super(SignInInitial());

  final SignInRepository _repository;
  final Box _globalBox;

  Future<void> signInUser({
    String username,
    String password,
  }) async {
    emit(SignInLoad());
    try {
      final signInResponse = await _repository.signInUser(
        username: username,
        password: password,
      );
      final loginResult = LoginResultDTO.fromJson(username, signInResponse);
      _globalBox.put(USERNAME, username);
      _globalBox.put(PASSWORD, encodeString(password));
      _globalBox.put(TOKEN, loginResult.jSessionId);
      emit(SignInSuccess(loginResult));
    } on SignInException catch (e) {
      emit(SignInFailure(e.errorMessage));
    }
  }
}
