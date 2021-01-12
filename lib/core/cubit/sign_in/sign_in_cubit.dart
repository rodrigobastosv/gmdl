import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entity/dto/login_result_dto.dart';
import '../../exception/exceptions.dart';
import '../../repository/sign_in_repository.dart';
import '../../store/store_provider.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    @required SignInRepository repository,
    @required this.storeProvider,
  })  : assert(repository != null),
        assert(storeProvider != null),
        _repository = repository,
        super(SignInInitial());

  final SignInRepository _repository;
  final StoreProvider storeProvider;

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
      storeProvider.storeSessionId(loginResult.jSessionId);
      emit(UserSignedSuccess(loginResult));
    } on SignInException {
      emit(UserSigningFailed());
    }
  }
}
