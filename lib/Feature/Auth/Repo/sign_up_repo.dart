import 'package:dartz/dartz.dart';
import 'package:resto_qr/Core/Models/app_exception.dart';
import 'package:resto_qr/Core/Models/user_model.dart';
import 'package:resto_qr/Core/Services/image_service.dart';
import 'package:resto_qr/Core/Services/supabase_auth.dart';
import 'package:resto_qr/Core/Services/supabase_function.dart';
import 'package:resto_qr/Core/Services/supabase_rpc.dart';

class SignUpRepo {
  SignUpRepo._();

  static SignUpRepo? _instance;

  factory SignUpRepo() => _instance ??= SignUpRepo._();

  final SupabaseAuth _auth = .new();

  final SupabaseRpc _rpc = .new();

  final SupabaseFunction _function = .new();

  Future<Either<AppException, UserModel>> signUp({
    required UserModel user,
    required String password,
    required String? imagePath,
  }) async {
    String? userId;
    try {
      var sign = await _auth
          .signUpWithEmailAndPassword(
            email: user.email,
            password: password,
            userName: user.userName,
          )
          .timeout(const .new(seconds: 15));

      if (sign != null) {
        userId = sign.id;
        var response = await ImageService()
            .singleUpload(
              uploadPath: '${sign.id}/logo',
              image: imagePath!,
            )
            .timeout(const .new(seconds: 45));

        var storedUser = user.copyWith(
          id: sign.id,
          restaurantLogoURL: response,
        );

        var loggedUser = await _rpc
            .call(
              function: 'complete_signup',
              params: storedUser.toRpc(),
            )
            .timeout(const .new(seconds: 15));

        var userData = loggedUser as Map<String, dynamic>;

        return right(UserModel.fromJson(userData));
      }

      return left(
        UnknownException(
          errorDetails: 'User creation failed without exception',
        ),
      );
    } catch (e, stackTrace) {
      if (userId != null) {
        await _function.call(name: 'delete_user', body: {'user_id': userId});
      }

      return left(
        ExceptionHandler.handle(
          error: e,
          stackTrace: stackTrace,
          isRpc: true,
          errorDetails: e.toString(),
        ),
      );
    }
  }
}
