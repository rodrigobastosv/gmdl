part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class UserSignedSuccess extends SignInState {
  UserSignedSuccess(this.loginResult);

  final LoginResultDTO loginResult;

  @override
  List<Object> get props => [loginResult];
}

class UserSigningFailed extends SignInState {
  UserSigningFailed(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
    errorMessage,
  ];
}

class UserSigningLoading extends SignInState {}
