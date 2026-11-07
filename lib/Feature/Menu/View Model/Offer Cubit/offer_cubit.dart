import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Cubit/safe_cubit.dart';
import 'package:resto_qr/Feature/Menu/Models/offer_model.dart';
import 'package:resto_qr/Feature/Menu/Repo/items_repo.dart';
import 'package:resto_qr/Feature/Menu/Repo/offers_repo.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Offer%20Cubit/offer_states.dart';

class OfferCubit extends Cubit<OfferStates> with SafeCubit {
  OfferCubit({required this.menuID}) : super(OfferInitialState()) {
    getOffers();
  }

  final OffersRepo _offersRepo = OffersRepo();

  final String menuID;

  StreamSubscription? _subscription;

  void getOffers() async {
    safeEmit(OffersLoading());

    _subscription = _offersRepo.offersStream.stream.listen(
      (items) {
        if (items.isEmpty) {
          safeEmit(OffersEmpty());
        } else {
          safeEmit(OffersLoaded(offers: items));
        }
      },
      onError: (error) {
        safeEmit(OffersError(message: error.toString()));
      },
    );

    await _offersRepo.getOffers(menuID: menuID);
  }

  void getAllItems({required String restaurantId}) async {
    safeEmit(OfferItemsLoading());

    var result = await ItemsRepo().getAllItems(restaurantId: restaurantId);

    result.fold(
      (l) => safeEmit(OfferItemsError(message: l.message)),
      (items) {
        if (items.isEmpty) {
          safeEmit(OfferItemsEmpty());
        } else {
          safeEmit(OfferItemsLoaded(items: items));
        }
      },
    );
  }

  void addOffer({
    required OfferModel offer,
    required String image,
  }) async {
    safeEmit(OffersLoading());

    var result = await _offersRepo.addItem(
      offer: offer,
      image: image,
    );

    result.fold(
      (l) => safeEmit(OfferAddError(message: l.message)),
      (r) => safeEmit(OfferAdded()),
    );
  }

  Future<void> updateOffer({required OfferModel offer, String? image}) async {
    safeEmit(OffersLoading());

    var result = await _offersRepo.updateOffer(
      offer: offer,
      menuID: menuID,
      image: image,
    );

    result.fold(
      (l) => safeEmit(OfferUpdateError(message: l.message)),
      (r) => safeEmit(OfferUpdated()),
    );
  }

  Future<void> deleteOffer({
    required OfferModel offer,
  }) async {
    safeEmit(OfferDeleteLoading());

    var result = await _offersRepo.deleteOffer(offer: offer);

    result.fold(
      (l) => safeEmit(OfferDeleteError(message: l.message)),
      (r) => safeEmit(OfferDeleted()),
    );
  }

  void toggleAvailability({
    required OfferModel offer,
    required bool isVisible,
  }) async {
    safeEmit(OfferToggleLoading());
    var result = await _offersRepo.toggleOfferVisibility(
      offer: offer,
      isVisible: isVisible,
    );

    result.fold(
      (l) => safeEmit(OfferToggleError(message: l.message)),
      (r) => safeEmit(OfferToggled(isActive: isVisible)),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _offersRepo.dispose();
    return super.close();
  }
}
