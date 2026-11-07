import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:resto_qr/Core/Cubit/safe_cubit.dart';
import 'package:resto_qr/Core/Models/user_model.dart';
import 'package:resto_qr/Feature/Auth/Repo/login_repo.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Login%20Cubit/login_state.dart';

class LoginCubit extends HydratedCubit<LoginState> with SafeCubit {
  LoginCubit() : super(LoginInitialState());

  final LoginRepo _repo = LoginRepo();

  void loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    safeEmit(LoginLoading());

    var user = await _repo.loginWithEmailAndPassword(
      email: email,
      password: password,
    );

    user.fold(
      (l) => safeEmit(LoginFailed(message: l.message)),
      (r) {
        safeEmit(LoginSuccess(user: r, openHome: true));
      },
    );
  }

  void quickLogin({required UserModel user, required bool openHome}) {
    user = user;
    safeEmit(LoginSuccess(user: user, openHome: openHome));
  }

  void logout() async {
    safeEmit(SignOutLoading());

    var res = await _repo.logout();

    res.fold(
      (l) => safeEmit(SignOutFailed(message: l.message)),
      (r) async {
        await clear();
        safeEmit(SignOutSuccess());
        safeEmit(LoginInitialState());
      },
    );
  }

  @override
  LoginState? fromJson(Map<String, dynamic> json) {
    try {
      return LoginSuccess(
        user: UserModel.fromJson(json),
        openHome: true,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(LoginState state) {
    if (state is LoginSuccess) {
      return state.user.toJson();
    }
    return null;
  }
}
