import 'package:resto_qr/Core/Base%20State/base_state.dart';
import 'package:resto_qr/Feature/Menu/Models/item_model.dart';
import 'package:resto_qr/Feature/Menu/Models/offer_model.dart';

class OfferStates {}

class OfferInitialState extends OfferStates {}

class OffersLoading extends OfferStates implements DataLoading {}

class OffersLoaded extends OfferStates implements DataLoaded {
  final List<OfferModel> offers;

  OffersLoaded({required this.offers});

  @override
  get data => offers;
}

class OffersEmpty extends OfferStates implements DataEmpty {}

class OffersError extends OfferStates implements DataError {
  final String message;

  OffersError({required this.message});

  @override
  get errorMessage => message;
}

class OfferAdded extends OfferStates {}

class OfferAddError extends OfferStates implements DataError {
  final String message;

  OfferAddError({required this.message});

  @override
  get errorMessage => message;
}

class OfferUpdated extends OfferStates {}

class OfferUpdateError extends OfferStates implements DataError {
  final String message;

  OfferUpdateError({required this.message});

  @override
  get errorMessage => message;
}

class OfferDeleted extends OfferStates {}

class OfferDeleteError extends OfferStates implements DataError {
  final String message;

  OfferDeleteError({required this.message});

  @override
  get errorMessage => message;
}

class OfferDeleteLoading extends OfferStates {}

class OfferToggled extends OfferStates {
  final bool isActive;

  OfferToggled({required this.isActive});
}

class OfferToggleLoading extends OfferStates {}

class OfferToggleError extends OfferStates implements DataError {
  final String message;

  OfferToggleError({required this.message});

  @override
  get errorMessage => message;
}

class OfferItemsLoading extends OfferStates implements DataLoading {}

class OfferItemsLoaded extends OfferStates implements DataLoaded {
  final List<ItemModel> items;

  OfferItemsLoaded({required this.items});

  @override
  get data => items;
}

class OfferItemsEmpty extends OfferStates implements DataEmpty {}

class OfferItemsError extends OfferStates implements DataError {
  final String message;

  OfferItemsError({required this.message});

  @override
  get errorMessage => message;
}
