import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Cubit/safe_cubit.dart';
import 'package:resto_qr/Feature/Auth/Repo/forgot_password_repo.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Forgot%20Password%20Cubit/forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> with SafeCubit {
  ForgotPasswordCubit() : super(ForgotPasswordInitialState());

  final ForgotPasswordRepo _repo = .new();

  void isUserExist({required String email}) async {
    safeEmit(ForgotPasswordLoading());

    var res = await _repo.isUserExists(email: email);

    res.fold(
      (l) => safeEmit(PasswordChangeFailed(message: l.message)),
      (r) => safeEmit(r ? UserExist() : UserNotExist()),
    );
  }

  void changePassword({required String email, required String password}) async {
    safeEmit(ForgotPasswordLoading());

    var res = await _repo.changePassword(
      email: email,
      password: password,
    );

    res.fold(
      (l) => safeEmit(PasswordChangeFailed(message: l.message)),
      (r) => safeEmit(PasswordChangeSuccess()),
    );
  }
}
