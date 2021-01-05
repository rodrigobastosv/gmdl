import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../entity/dto/login_result_dto.dart';
import '../../exception/exceptions.dart';
import '../../hive/boxes.dart';
import '../../repository/sign_in_repository.dart';
import 'package:hive/hive.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    @required this.repository,
    @required this.securityBox,
  })  : assert(repository != null),
        super(SignInInitial());

  final SignInRepository repository;
  final Box securityBox;

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
      securityBox.put(SESSION_ID, loginResult.jSessionId);
      emit(UserSignedSuccess(loginResult));
    } on SignInException {
      emit(UserSigningFailed());
    }
  }
}
