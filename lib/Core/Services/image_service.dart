import 'dart:developer';

import 'package:resto_qr/Core/Services/api_service.dart';
import 'package:resto_qr/Core/Services/supabase_function.dart';

class ImageService {
  final ApiService _apiService = ApiService();

  final SupabaseFunction _supabaseFunction = SupabaseFunction();

  Future<String> singleUpload({
    required String uploadPath,
    required String image,
  }) async {
    try {
      var response = await _apiService.multipartPost(
        url:
            'https://kmzvxuzparxejoiawtoy.supabase.co/functions/v1/upload_image',
        fields: {
          'path': uploadPath,
        },
        files: {
          'file': image,
        },
      );

      return response['image_url'];
    } catch (e) {
      throw Exception('Image upload failed: $e');
    }
  }

  Future<List<String>> multiUpload({
    required String uploadPath,
    required List<String> image,
  }) async {
    try {
      var response = await Future.wait(
        image.map(
          (img) async => await _apiService.multipartPost(
            url:
                'https://kmzvxuzparxejoiawtoy.supabase.co/functions/v1/upload_image',
            fields: {
              'path': uploadPath,
            },
            files: {
              'file': img,
            },
          ),
        ),
      );

      var imageUrls = response
          .map((res) => res['image_url'] as String)
          .toList();

      return imageUrls;
    } catch (e) {
      throw Exception('Image upload failed: $e');
    }
  }

  Future<void> deleteImage({
    required String imageUrl,
  }) async {
    try {
      await _supabaseFunction.call(
        name: 'delete_image',
        body: {'image_url': imageUrl},
      );
    } catch (e) {
      log(e.toString());
      throw Exception('Image deletion failed: $e');
    }
  }

  Future<void> deleteImages({
    required List<String> imageUrls,
  }) async {
    try {
      await _supabaseFunction.call(
        name: 'delete_multiple_images',
        body: {'image_urls': imageUrls},
      );
    } catch (e) {
      log(e.toString());
      throw Exception('Image deletion failed: $e');
    }
  }
}
