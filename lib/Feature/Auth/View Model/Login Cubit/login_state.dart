import 'package:resto_qr/Core/Models/user_model.dart';

sealed class LoginState {
  final UserModel user;

  LoginState({this.user = const EmptyUser()});
}

class LoginInitialState extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final bool openHome;

  LoginSuccess({required super.user, required this.openHome});
}

class LoginFailed extends LoginState {
  final String message;

  LoginFailed({required this.message});
}

class SignOutSuccess extends LoginState {
  SignOutSuccess();
}

class SignOutFailed extends LoginState {
  final String message;

  SignOutFailed({required this.message});
}

class SignOutLoading extends LoginState {}
