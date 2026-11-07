import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:resto_qr/Core/Models/app_exception.dart';
import 'package:resto_qr/Core/Models/user_model.dart';
import 'package:resto_qr/Core/Services/image_service.dart';
import 'package:resto_qr/Core/Services/supabase_rpc.dart';
import 'package:resto_qr/Core/Utils/image_compress.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileSettingsRepo {
  final SupabaseRpc _rpc = SupabaseRpc();

  final ImageCompress _imageCompress = ImageCompress();

  final ImageService _imageService = ImageService();

  Future<Either<AppException, UserModel>> updateProfileSettings({
    required String userId,
    required String userName,
    required String restaurantName,
    required String phoneNumber,
    required String oldImagePath,
    String? imagePath,
  }) async {
    try {
      String? imageUrl;
      if (imagePath != null) {
        final compressedImage = await _imageCompress
            .compressToPath(imagePath)
            .timeout(const .new(seconds: 15));

        if (compressedImage != null) {
          imageUrl = await _imageService
              .singleUpload(
                image: compressedImage,
                uploadPath: '$userId/logo',
              )
              .timeout(const .new(seconds: 45));

          await _imageService
              .deleteImage(imageUrl: oldImagePath)
              .timeout(const .new(seconds: 15));
        } else {
          return left(
            UnknownException(errorDetails: 'Image compression failed'),
          );
        }
      }

      var res = await _rpc
          .call(
            function: 'update_profile',
            params: {
              'p_owner_id': userId,
              'p_user_name': userName,
              'p_restaurant_name': restaurantName,
              'p_phone': phoneNumber,
              'p_logo_url': imageUrl ?? oldImagePath,
            },
          )
          .timeout(const .new(seconds: 15));

      var user = res as Map<String, dynamic>;

      return right(UserModel.fromJson(user));
    } catch (e, stackTrace) {
      if (e is PostgrestException) {
        log('Supabase Error Message: ${e.message}');
        log('Supabase Error Details: ${e.details}');
        log('Supabase Error Hint: ${e.hint}');
      }
      return left(
        ExceptionHandler.handle(
          error: e,
          stackTrace: stackTrace,
          isRpc: true,
        ),
      );
    }
  }
}
