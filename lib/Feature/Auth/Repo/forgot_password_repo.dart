import 'package:dartz/dartz.dart';
import 'package:resto_qr/Core/Models/app_exception.dart';
import 'package:resto_qr/Core/Services/supabase_function.dart';

class ForgotPasswordRepo {
  ForgotPasswordRepo._();

  static ForgotPasswordRepo? _instance;

  factory ForgotPasswordRepo() => _instance ??= ForgotPasswordRepo._();

  final SupabaseFunction _function = SupabaseFunction();

  Future<Either<AppException, bool>> isUserExists({
    required String email,
  }) async {
    try {
      var res = await _function
          .call(
            name: 'is_user_exists',
            body: {'email': email},
          )
          .timeout(const .new(seconds: 15));

      var data = res.data as Map<String, dynamic>;

      return right(data['exists'] as bool);
    } catch (e, stackTrace) {
      return left(ExceptionHandler.handle(error: e, stackTrace: stackTrace));
    }
  }

  Future<Either<AppException, Unit>> changePassword({
    required String email,
    required String password,
  }) async {
    try {
      var res = await _function
          .call(
            name: 'change_password',
            body: {
              'email': email,
              'new_password': password,
            },
          )
          .timeout(const .new(seconds: 15));

      final data = res.data as Map<String, dynamic>;

      if (data.containsKey('error')) {
        return left(UnknownException(errorDetails: data['error'].toString()));
      }

      return right(unit);
    } catch (e, stackTrace) {
      return left(ExceptionHandler.handle(error: e, stackTrace: stackTrace));
    }
  }
}
