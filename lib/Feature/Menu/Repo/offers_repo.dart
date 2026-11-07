import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:resto_qr/Core/Models/app_exception.dart';
import 'package:resto_qr/Core/Services/image_service.dart';
import 'package:resto_qr/Core/Services/supabase_db.dart';
import 'package:resto_qr/Core/Services/supabase_rpc.dart';
import 'package:resto_qr/Core/Utils/image_compress.dart';
import 'package:resto_qr/Core/Utils/stream_wrapper.dart';
import 'package:resto_qr/Feature/Menu/Models/offer_model.dart';

class OffersRepo {
  OffersRepo._();

  static OffersRepo? _instance;

  factory OffersRepo() => _instance ??= OffersRepo._();

  final SupabaseRpc _rpc = SupabaseRpc();

  final SupabaseDb _db = SupabaseDb();

  final ImageService _imageService = ImageService();

  final ImageCompress _imageCompress = ImageCompress();

  final StreamWrapper<List<OfferModel>> offersStream = StreamWrapper(
    initialValue: [],
    broadcast: true,
  );

  List<OfferModel> _offers = [];

  Future<Either<AppException, Unit>> getOffers({
    required String menuID,
  }) async {
    if (_offers.isNotEmpty) {
      return right(unit);
    } else {
      try {
        var response = await _rpc
            .call(
              function: 'get_offers',
              params: {'p_menu_id': menuID},
            )
            .timeout(const .new(seconds: 15));

        var data = List<Map<String, dynamic>>.from(response as List);

        _offers = data.map((e) => OfferModel.fromJson(e)).toList();

        offersStream.update(List.from(_offers));

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

  Future<Either<AppException, Unit>> addItem({
    required OfferModel offer,
    required String image,
  }) async {
    try {
      String? imagePath;

      var compress = await _imageCompress
          .compressToPath(image)
          .timeout(const .new(seconds: 15));

      imagePath = compress;

      if (imagePath != null) {
        String imageUrl = await _imageService
            .singleUpload(
              uploadPath: '${offer.menuId}/offers',
              image: imagePath,
            )
            .timeout(const .new(seconds: 45));

        var data = await _rpc
            .call(
              function: 'add_offer',
              params: offer.copyWith(imageUrl: imageUrl).toRpc(),
            )
            .timeout(const .new(seconds: 15));

        var newItem = data as Map<String, dynamic>;

        log('New Offer Added: $newItem');

        _offers.add(OfferModel.fromJson(newItem));

        log('Offers List After Adding: $_offers');

        _offers.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

        log('Offers List After Sorting: $_offers');

        offersStream.update(List.from(_offers));

        log('Offers Stream Updated: ${offersStream.value}');

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

  Future<Either<AppException, Unit>> updateOffer({
    required OfferModel offer,
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
                uploadPath: '$menuID/offers',
                image: newPath,
              )
              .timeout(const .new(seconds: 45));

          await _imageService
              .deleteImage(imageUrl: offer.imageUrl)
              .timeout(const .new(seconds: 15));

          offer = offer.copyWith(imageUrl: imageUrl);
        } else {
          return left(
            UnknownException(errorDetails: 'Image compression failed'),
          );
        }
      }
      var response = await _rpc
          .call(
            function: 'update_offer',
            params: offer.toUpdateRpc(),
          )
          .timeout(const .new(seconds: 15));

      var data = response as Map<String, dynamic>;

      var newOffer = OfferModel.fromJson(data);

      _offers = (_offers).map((o) {
        if (o.id == newOffer.id) {
          return newOffer;
        } else {
          return o;
        }
      }).toList();

      offersStream.update(List.from(_offers));

      return right(unit);
    } catch (e, stackTrace) {
      return left(
        ExceptionHandler.handle(error: e, stackTrace: stackTrace, isRpc: true),
      );
    }
  }

  Future<Either<AppException, Unit>> deleteOffer({
    required OfferModel offer,
  }) async {
    try {
      await _imageService
          .deleteImage(
            imageUrl: offer.imageUrl,
          )
          .timeout(const .new(seconds: 15));

      await _db
          .delete(table: 'offers', id: offer.id)
          .timeout(const .new(seconds: 15));

      _offers.removeWhere((o) => o.id == offer.id);

      offersStream.update(List.from(_offers));

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

  Future<Either<AppException, Unit>> toggleOfferVisibility({
    required OfferModel offer,
    required bool isVisible,
  }) async {
    try {
      await _db
          .update(
            table: 'offers',
            id: offer.id,
            data: {'is_visible': isVisible},
          )
          .timeout(const .new(seconds: 15));

      _offers = (_offers).map((o) {
        if (o.id == offer.id) {
          return o.copyWith(isVisible: isVisible);
        } else {
          return o;
        }
      }).toList();

      offersStream.update(List.from(_offers));

      return right(unit);
    } catch (e, stackTrace) {
      log('Error toggling offer visibility: $e');
      return left(
        ExceptionHandler.handle(error: e, stackTrace: stackTrace),
      );
    }
  }

  void dispose() {
    _offers.clear();
    offersStream.value?.clear();
  }
}
