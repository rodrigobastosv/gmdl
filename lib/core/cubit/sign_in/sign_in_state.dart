part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInSuccess extends SignInState {
  SignInSuccess(this.loginResult);

  final LoginResultDTO loginResult;

  @override
  List<Object> get props => [loginResult];
}

class SignInFailure extends SignInState {
  SignInFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class SignInLoad extends SignInState {}
