import 'package:dartz/dartz.dart';
import 'package:resto_qr/Core/Models/app_exception.dart';
import 'package:resto_qr/Core/Services/image_service.dart';
import 'package:resto_qr/Core/Services/supabase_db.dart';
import 'package:resto_qr/Core/Services/supabase_function.dart';
import 'package:resto_qr/Core/Services/supabase_rpc.dart';
import 'package:resto_qr/Core/Utils/image_compress.dart';
import 'package:resto_qr/Core/Utils/stream_wrapper.dart';
import 'package:resto_qr/Feature/Menu/Models/item_model.dart';

class ItemsRepo {
  ItemsRepo._();

  static ItemsRepo? _instance;

  factory ItemsRepo() => _instance ??= ItemsRepo._();

  final SupabaseRpc _rpc = SupabaseRpc();

  final SupabaseDb _db = SupabaseDb();

  final SupabaseFunction _function = SupabaseFunction();

  final ImageService _imageService = ImageService();

  final ImageCompress _imageCompress = ImageCompress();

  final StreamWrapper<List<ItemModel>> itemsStream = StreamWrapper(
    initialValue: [],
    broadcast: true,
  );

  List<ItemModel> _items = [];

  List<ItemModel> _allItems = [];

  Future<Either<AppException, Unit>> getItems({
    required String categoryID,
  }) async {
    if (_items.isNotEmpty) {
      return right(unit);
    } else {
      try {
        var response = await _rpc
            .call(
              function: 'get_items',
              params: {'p_category_id': categoryID},
            )
            .timeout(const .new(seconds: 15));

        var data = List<Map<String, dynamic>>.from(response as List);

        _items = data.map((e) => ItemModel.fromMap(e)).toList();

        itemsStream.update(List.from(_items));

        return right(unit);
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
  }

  Future<Either<AppException, List<ItemModel>>> getAllItems({
    required String restaurantId,
  }) async {
    try {
      var response = await _db
          .get(table: 'menu_items')
          .eq('restaurant_id', restaurantId)
          .select()
          .timeout(const .new(seconds: 15));

      var data = List<Map<String, dynamic>>.from(response as List);

      _allItems = data.map((e) => ItemModel.fromMap(e)).toList();

      return right(_allItems);
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

  Future<Either<AppException, Unit>> addItem({
    required ItemModel item,
    required List<String> images,
    required String categoryID,
  }) async {
    try {
      List<String?> imagePaths = [];

      imagePaths = await Future.wait(
        images.map((image) async {
          var newPath = await _imageCompress.compressToPath(image);
          return newPath;
        }),
      ).timeout(const .new(seconds: 15));

      imagePaths.removeWhere((path) => path == null);

      if (imagePaths.isNotEmpty) {
        List<String> imageUrls = await _imageService
            .multiUpload(
              uploadPath: '$categoryID/items',
              image: imagePaths.cast<String>(),
            )
            .timeout(const .new(seconds: 45));

        var data = await _rpc
            .call(
              function: 'add_item',
              params: item.copyWith(imageURL: imageUrls).toRpc(),
            )
            .timeout(const .new(seconds: 15));

        var newItem = data as Map<String, dynamic>;

        _items.add(ItemModel.fromMap(newItem));

        _items.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

        itemsStream.update(List.from(_items));

        return right(unit);
      }

      return left(
        UnknownException(
          errorDetails: 'Image upload failed due to compression issues',
        ),
      );
    } catch (e, stackTrace) {
      // if (e is PostgrestException) {
      //   log('Supabase Error Message: ${e.message}');
      //   log('Supabase Error Details: ${e.details}');
      //   log('Supabase Error Hint: ${e.hint}');
      // }
      return left(
        ExceptionHandler.handle(
          error: e,
          stackTrace: stackTrace,
          isRpc: true,
        ),
      );
    }
  }

  Future<Either<AppException, Unit>> updateItem({
    required ItemModel item,
    required String categoryID,
    List<String>? images,
    List<String>? deletedImageUrls,
  }) async {
    try {
      if (images != null && images.isNotEmpty) {
        List<String?> imagePaths = await Future.wait(
          images.map((image) async {
            var newPath = await _imageCompress.compressToPath(image);
            return newPath;
          }),
        ).timeout(const .new(seconds: 15));

        //clean nulls
        imagePaths.removeWhere((path) => path == null);

        if (imagePaths.isNotEmpty) {
          List<String> imageUrls = await _imageService
              .multiUpload(
                uploadPath: '$categoryID/items',
                image: imagePaths.cast<String>(),
              )
              .timeout(const .new(seconds: 45));

          item.mergeImage(imageUrls);
        }
      }

      if (deletedImageUrls != null && deletedImageUrls.isNotEmpty) {
        await _function
            .call(
              name: 'delete_multiple_images',
              body: {'image_urls': deletedImageUrls},
            )
            .timeout(const .new(seconds: 15));

        item.imageURL.removeWhere(
          (element) => deletedImageUrls.contains(element),
        );
      }

      var response = await _rpc
          .call(
            function: 'update_item',
            params: item.toUpdateRpc(),
          )
          .timeout(const .new(seconds: 15));

      var data = response as Map<String, dynamic>;

      var newItem = ItemModel.fromMap(data);

      _items = (_items).map((i) {
        if (i.id == newItem.id) {
          return newItem;
        } else {
          return i;
        }
      }).toList();

      itemsStream.update(List.from(_items));

      return right(unit);
    } catch (e, stackTrace) {
      // if (e is PostgrestException) {
      //   log('Supabase Error Message: ${e.message}');
      //   log('Supabase Error Details: ${e.details}');
      //   log('Supabase Error Hint: ${e.hint}');
      // }
      return left(
        ExceptionHandler.handle(
          error: e,
          stackTrace: stackTrace,
          isRpc: true,
        ),
      );
    }
  }

  Future<Either<AppException, Unit>> deleteItem({
    required ItemModel item,
  }) async {
    try {
      await _imageService
          .deleteImages(
            imageUrls: item.imageURL,
          )
          .timeout(const .new(seconds: 15));

      await _db
          .delete(table: 'menu_items', id: item.id!)
          .timeout(const .new(seconds: 15));

      _items.removeWhere((i) => i.id == item.id);

      itemsStream.update(List.from(_items));

      return right(unit);
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

  Future<Either<AppException, Unit>> toggleItemVisibility({
    required ItemModel item,
    required bool isVisible,
  }) async {
    try {
      await _db
          .update(
            table: 'menu_items',
            id: item.id!,
            data: {'is_visible': isVisible},
          )
          .timeout(const .new(seconds: 15));

      _items.firstWhere((i) => i.id == item.id).isVisible = isVisible;

      itemsStream.update(List.from(_items));

      return right(unit);
    } catch (e, stackTrace) {
      return left(
        ExceptionHandler.handle(error: e, stackTrace: stackTrace),
      );
    }
  }

  void dispose() {
    _items.clear();
    itemsStream.value?.clear();
  }
}
