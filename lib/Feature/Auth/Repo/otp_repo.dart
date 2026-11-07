import 'package:dartz/dartz.dart';
import 'package:resto_qr/Core/Models/app_exception.dart';
import 'package:resto_qr/Core/Services/supabase_function.dart';

class OtpRepo {
  OtpRepo._();

  static OtpRepo? _instance;

  factory OtpRepo() => _instance ??= OtpRepo._();

  final SupabaseFunction _function = .new();

  Future<Either<AppException, Unit>> sendOTP({required String email}) async {
    try {
      var res = await _function
          .call(
            name: 'send_otp',
            body: {'email': email},
          )
          .timeout(const .new(seconds: 15));

      if (res.status == 200) {
        return right(unit);
      } else {
        return left(
          UnknownException(errorDetails: res.toString()),
        );
      }
    } catch (e, stackTrace) {
      return left(
        ExceptionHandler.handle(
          error: e,
          stackTrace: stackTrace,
          errorDetails: e.toString(),
        ),
      );
    }
  }

  Future<Either<AppException, Unit>> verifyOTP({
    required String email,
    required String code,
  }) async {
    try {
      var res = await _function
          .call(
            name: 'verify_otp',
            body: {'email': email, 'code': code},
          )
          .timeout(const .new(seconds: 15));

      if (res.status == 200) {
        return right(unit);
      } else {
        return left(
          UnknownException(errorDetails: res.toString()),
        );
      }
    } catch (e, stackTrace) {
      return left(
        ExceptionHandler.handle(
          error: e,
          stackTrace: stackTrace,
          errorDetails: e.toString(),
        ),
      );
    }
  }
}
