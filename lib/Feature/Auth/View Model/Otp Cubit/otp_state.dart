sealed class OtpState {}

class OtpInitialState extends OtpState {}

class OtpSent extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {}

class OtpFailed extends OtpState {
  final String message;

  OtpFailed({required this.message});
}

class OtpFinish extends OtpState {}
