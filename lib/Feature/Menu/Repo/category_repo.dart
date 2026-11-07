import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:resto_qr/Core/Models/app_exception.dart';
import 'package:resto_qr/Core/Services/image_service.dart';
import 'package:resto_qr/Core/Services/supabase_db.dart';
import 'package:resto_qr/Core/Services/supabase_rpc.dart';
import 'package:resto_qr/Core/Utils/image_compress.dart';
import 'package:resto_qr/Core/Utils/stream_wrapper.dart';
import 'package:resto_qr/Feature/Menu/Models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryRepo {
  CategoryRepo._();

  static CategoryRepo? _instance;

  factory CategoryRepo() => _instance ??= CategoryRepo._();

  final SupabaseRpc _rpc = SupabaseRpc();

  final SupabaseDb _db = SupabaseDb();

  final ImageService _imageService = ImageService();

  final ImageCompress _imageCompress = ImageCompress();

  final StreamWrapper<List<CategoryModel>> categoriesStream = StreamWrapper(
    initialValue: [],
    broadcast: true,
  );

  List<CategoryModel> _categories = [];

  Future<Either<AppException, List<CategoryModel>>> getCateogries({
    required String menuID,
  }) async {
    if (_categories.isNotEmpty) {
      return right(_categories);
    } else {
      try {
        var response = await _rpc
            .call(
              function: 'get_categories',
              params: {'p_menu_id': menuID},
            )
            .timeout(const .new(seconds: 15));

        var data = List<Map<String, dynamic>>.from(response as List);

        _categories = data.map((e) => CategoryModel.fromMap(e)).toList();

        categoriesStream.update(List.from(_categories));

        return right(_categories);
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

  Future<Either<AppException, Unit>> addCategory({
    required CategoryModel category,
    required String image,
    required String menuID,
  }) async {
    try {
      var newPath = await _imageCompress
          .compressToPath(image)
          .timeout(const .new(seconds: 15));

      if (newPath != null) {
        var imageUrl = await _imageService
            .singleUpload(
              uploadPath: '$menuID/categories',
              image: image,
            )
            .timeout(const .new(seconds: 45));

        var response = await _rpc
            .call(
              function: 'add_category',
              params: category.copyWith(imageURL: imageUrl).toRpc(),
            )
            .timeout(const .new(seconds: 15));

        var data = response as Map<String, dynamic>;

        var newCategory = CategoryModel.fromMap(data);

        _categories.add(newCategory);

        _categories.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

        categoriesStream.update(List.from(_categories));

        return right(unit);
      }

      return left(UnknownException(errorDetails: 'Image compression failed'));
    } catch (e, stackTrace) {
      return left(
        ExceptionHandler.handle(
          error: e,
          stackTrace: stackTrace,
          isRpc: true,
        ),
      );
    }
  }

  Future<Either<AppException, Unit>> updateCategory({
    required CategoryModel category,
    String? image,
    required String menuID,
  }) async {
    try {
      if (image != null) {
        var newPath = await _imageCompress
            .compressToPath(image)
            .timeout(const .new(seconds: 15));

        if (newPath != null) {
          var imageUrl = await _imageService
              .singleUpload(
                uploadPath: '$menuID/categories',
                image: newPath,
              )
              .timeout(const .new(seconds: 45));

          await _imageService
              .deleteImage(imageUrl: category.imageURL!)
              .timeout(const .new(seconds: 15));

          category = category.copyWith(imageURL: imageUrl);
        } else {
          return left(
            UnknownException(errorDetails: 'Image compression failed'),
          );
        }
      }
      var response = await _rpc
          .call(
            function: 'update_category',
            params: category.toUpdateRpc(),
          )
          .timeout(const .new(seconds: 15));

      var data = response as Map<String, dynamic>;

      var newCategory = CategoryModel.fromMap(data);

      _categories = (_categories).map((c) {
        if (c.id == newCategory.id) {
          return newCategory;
        } else {
          return c;
        }
      }).toList();

      categoriesStream.update(List.from(_categories));

      return right(unit);
    } catch (e, stackTrace) {
      return left(
        ExceptionHandler.handle(error: e, stackTrace: stackTrace, isRpc: true),
      );
    }
  }

  Future<Either<AppException, Unit>> deleteCategory({
    required CategoryModel category,
  }) async {
    try {
      await _imageService
          .deleteImage(imageUrl: category.imageURL!)
          .timeout(const .new(seconds: 15));

      await _db
          .delete(table: 'categories', id: category.id!)
          .timeout(const .new(seconds: 15));

      _categories.removeWhere((c) => c.id == category.id);

      categoriesStream.update(List.from(_categories));

      return right(unit);
    } catch (e, stackTrace) {
      return left(
        ExceptionHandler.handle(error: e, stackTrace: stackTrace, isRpc: true),
      );
    }
  }

  Future<Either<AppException, Unit>> toggleCategoryVisibility({
    required CategoryModel category,
    required bool isVisible,
  }) async {
    try {
      await _db
          .update(
            table: 'categories',
            id: category.id!,
            data: {'is_visible': isVisible},
          )
          .timeout(const .new(seconds: 15));

      _categories.firstWhere((c) => c.id == category.id).isVisible = isVisible;

      categoriesStream.update(List.from(_categories));

      return right(unit);
    } catch (e, stackTrace) {
      return left(
        ExceptionHandler.handle(error: e, stackTrace: stackTrace),
      );
    }
  }

  void dispose() {
    categoriesStream.dispose();
  }
}
