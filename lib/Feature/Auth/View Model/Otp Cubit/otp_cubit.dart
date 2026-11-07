import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Cubit/safe_cubit.dart';
import 'package:resto_qr/Feature/Auth/Repo/otp_repo.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Otp%20Cubit/otp_state.dart';

class OtpCubit extends Cubit<OtpState> with SafeCubit {
  OtpCubit({required this.email}) : super(OtpInitialState()) {
    sendOTP();
  }

  final OtpRepo _repo = .new();

  final String email;

  void sendOTP() async {
    safeEmit(OtpLoading());
    var res = await _repo.sendOTP(email: email);
    res.fold(
      (l) => safeEmit(OtpFailed(message: l.message)),
      (r) => safeEmit(OtpSent()),
    );
  }

  void verifyOTP({required String code}) async {
    safeEmit(OtpLoading());
    var res = await _repo.verifyOTP(email: email, code: code);
    res.fold(
      (l) => safeEmit(OtpFailed(message: l.message)),
      (r) => safeEmit(OtpSuccess()),
    );
  }
}
