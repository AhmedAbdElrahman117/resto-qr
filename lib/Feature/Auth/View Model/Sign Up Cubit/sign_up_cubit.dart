import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Cubit/safe_cubit.dart';
import 'package:resto_qr/Core/Models/user_model.dart';
import 'package:resto_qr/Feature/Auth/Repo/sign_up_repo.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Sign%20Up%20Cubit/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> with SafeCubit {
  SignUpCubit() : super(SignUpInitialState());

  final SignUpRepo _repo = SignUpRepo();

  Future<void> signUp({
    required UserModel user,
    required String password,
    required String? imagePath,
  }) async {
    safeEmit(SignUpLoading());

    var res = await _repo.signUp(
      user: user,
      password: password,
      imagePath: imagePath,
    );

    res.fold(
      (l) => safeEmit(SignUpFailed(message: l.message)),
      (r) => safeEmit(SignUpSucces(user: r)),
    );
  }
}
