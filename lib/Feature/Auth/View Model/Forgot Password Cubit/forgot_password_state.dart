sealed class ForgotPasswordState {}

class ForgotPasswordInitialState extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class UserExist extends ForgotPasswordState {}

class UserNotExist extends ForgotPasswordState {}

class PasswordChangeSuccess extends ForgotPasswordState {}

class PasswordChangeFailed extends ForgotPasswordState {
  final String message;

  PasswordChangeFailed({required this.message});
}
