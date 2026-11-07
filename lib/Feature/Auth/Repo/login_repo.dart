import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:resto_qr/Core/Models/app_exception.dart';
import 'package:resto_qr/Core/Models/user_model.dart';
import 'package:resto_qr/Core/Services/supabase_auth.dart';
import 'package:resto_qr/Core/Services/supabase_rpc.dart';

class LoginRepo {
  LoginRepo._();

  static LoginRepo? _instance;

  factory LoginRepo() => _instance ??= LoginRepo._();

  final SupabaseAuth _auth = SupabaseAuth();

  final SupabaseRpc _rpc = SupabaseRpc();

  Future<Either<AppException, UserModel>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var user = await _auth
          .loginWithEmailAndPassword(
            email: email,
            password: password,
          )
          .timeout(const .new(seconds: 15));

      if (user != null) {
        var data = await _rpc
            .call(function: 'user_login', params: {'p_id': user.id})
            .timeout(const .new(seconds: 15));

        return right(UserModel.fromJson(data));
      }

      return left(UnknownException(errorDetails: 'No Such User'));
    } catch (e, stackTrace) {
      log(e.toString());
      return left(ExceptionHandler.handle(error: e, stackTrace: stackTrace));
    }
  }

  Future<Either<AppException, Unit>> logout() async {
    try {
      await _auth.logout().timeout(const .new(seconds: 15));
      return right(unit);
    } catch (e, stackTrace) {
      return left(ExceptionHandler.handle(error: e, stackTrace: stackTrace));
    }
  }
}
