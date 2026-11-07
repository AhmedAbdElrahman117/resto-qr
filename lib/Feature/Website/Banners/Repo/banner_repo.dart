import 'package:dartz/dartz.dart';
import 'package:resto_qr/Core/Models/app_exception.dart';
import 'package:resto_qr/Core/Services/image_service.dart';
import 'package:resto_qr/Core/Services/supabase_db.dart';
import 'package:resto_qr/Core/Services/supabase_rpc.dart';
import 'package:resto_qr/Core/Utils/image_compress.dart';
import 'package:resto_qr/Core/Utils/stream_wrapper.dart';
import 'package:resto_qr/Feature/Website/Banners/Models/banner_model.dart';

class BannerRepo {
  BannerRepo._();

  static BannerRepo? _instance;

  factory BannerRepo() => _instance ??= BannerRepo._();

  final StreamWrapper<List<BannerModel>> _bannersStreamWrapper = StreamWrapper(
    broadcast: true,
  );

  Stream<List<BannerModel>> get stream => _bannersStreamWrapper.stream;

  List<BannerModel> _banners = [];

  List<Map<String, dynamic>> _cachedItems = [];

  final SupabaseDb _db = SupabaseDb();

  final SupabaseRpc _rpc = SupabaseRpc();

  final ImageCompress _imageCompress = ImageCompress();

  final ImageService _imageService = ImageService();

  Future<Either<AppException, Unit>> getBanners({
    required String menuID,
  }) async {
    try {
      final res = await _db
          .get(table: 'banners')
          .eq('menu_id', menuID)
          .order('created_at', ascending: false)
          .timeout(const .new(seconds: 15));

      _banners = (res as List).map((e) => BannerModel.fromMap(e)).toList();

      _bannersStreamWrapper.update(List.from(_banners));

      return right(unit);
    } catch (e, stackTrace) {
      return left(ExceptionHandler.handle(error: e, stackTrace: stackTrace));
    }
  }

  Future<Either<AppException, List<Map<String, dynamic>>>> getMenuItems({
    required String ownerId,
  }) async {
    if (_cachedItems.isNotEmpty) return right(_cachedItems);

    try {
      final res = await _db
          .get(table: 'menu_items', columns: 'id, name')
          .eq('owner_id', ownerId)
          .timeout(const .new(seconds: 15));

      _cachedItems = List<Map<String, dynamic>>.from(res);

      return right(_cachedItems);
    } catch (e, stackTrace) {
      return left(ExceptionHandler.handle(error: e, stackTrace: stackTrace));
    }
  }

  Future<Either<AppException, Unit>> addBanner({
    required BannerModel banner,
    required String image,
  }) async {
    try {
      var compressedImage = await _imageCompress
          .compressToPath(image)
          .timeout(const .new(seconds: 15));

      if (compressedImage != null) {
        final imageUrl = await _imageService
            .singleUpload(
              image: compressedImage,
              uploadPath: '${banner.menuId}/banners',
            )
            .timeout(const .new(seconds: 45));

        var res = await _rpc
            .call(
              function: 'add_banner',
              params: banner.copyWith(imageUrl: imageUrl).toAddRPC(),
            )
            .timeout(const .new(seconds: 15));

        final newBanner = BannerModel.fromMap(res);

        _banners.add(newBanner);

        _banners.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        _bannersStreamWrapper.update(List.from(_banners));

        return right(unit);
      }

      return left(UnknownException(errorDetails: 'Image compression failed'));
    } catch (e, stackTrace) {
      return left(ExceptionHandler.handle(error: e, stackTrace: stackTrace));
    }
  }

  Future<Either<AppException, Unit>> updateBanner({
    required BannerModel banner,
    String? image,
  }) async {
    try {
      if (image != null) {
        var compressedImage = await _imageCompress
            .compressToPath(image)
            .timeout(const .new(seconds: 15));

        if (compressedImage != null) {
          final newImage = await _imageService
              .singleUpload(
                image: compressedImage,
                uploadPath: '${banner.menuId}/banners',
              )
              .timeout(const .new(seconds: 45));

          await _imageService
              .deleteImage(imageUrl: banner.imageUrl)
              .timeout(const .new(seconds: 15));

          banner = banner.copyWith(imageUrl: newImage);
        } else {
          return left(
            UnknownException(errorDetails: 'Image compression failed'),
          );
        }
      }

      var res = await _rpc
          .call(
            function: 'update_banner',
            params: banner.toUpdateRPC(),
          )
          .timeout(const .new(seconds: 15));

      final updatedBanner = BannerModel.fromMap(res);

      final index = _banners.indexWhere((b) => b.id == banner.id);

      if (index != -1) {
        _banners[index] = updatedBanner;
      }

      _bannersStreamWrapper.update(List.from(_banners));

      return right(unit);
    } catch (e, stackTrace) {
      return left(ExceptionHandler.handle(error: e, stackTrace: stackTrace));
    }
  }

  Future<Either<AppException, Unit>> deleteBanner({
    required BannerModel banner,
  }) async {
    try {
      await _imageService
          .deleteImage(
            imageUrl: banner.imageUrl,
          )
          .timeout(const .new(seconds: 15));

      await _db
          .delete(
            table: 'banners',
            id: banner.id,
          )
          .timeout(const .new(seconds: 15));

      _banners.removeWhere((b) => b.id == banner.id);

      _bannersStreamWrapper.update(List.from(_banners));

      return right(unit);
    } catch (e, stackTrace) {
      return left(ExceptionHandler.handle(error: e, stackTrace: stackTrace));
    }
  }

  Future<Either<AppException, Unit>> toggleBannerActive({
    required BannerModel banner,
  }) async {
    try {
      final newStatus = !banner.isLive;

      await _db
          .update(
            table: 'banners',
            id: banner.id,
            data: {'is_live': newStatus},
          )
          .timeout(const .new(seconds: 15));

      final index = _banners.indexWhere((b) => b.id == banner.id);

      if (index != -1) {
        _banners[index] = banner.copyWith(isLive: newStatus);
      }

      _bannersStreamWrapper.update(List.from(_banners));

      return right(unit);
    } catch (e, stackTrace) {
      return left(ExceptionHandler.handle(error: e, stackTrace: stackTrace));
    }
  }
}
