import 'package:resto_qr/Core/Models/user_model.dart';

class SignUpState {}

class SignUpInitialState extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSucces extends SignUpState {
  final UserModel user;
  SignUpSucces({required this.user});
}

class SignUpFailed extends SignUpState {
  final String message;

  SignUpFailed({required this.message});
}
