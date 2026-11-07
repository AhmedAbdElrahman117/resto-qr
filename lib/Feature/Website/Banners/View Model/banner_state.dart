import 'package:resto_qr/Core/Base%20State/base_state.dart';
import 'package:resto_qr/Feature/Website/Banners/Models/banner_model.dart';

class BannerState {}

class BannerInitialState extends BannerState {}

class BannerLoadingState extends BannerState implements DataLoading {}

class BannerEmptyState extends BannerState implements DataEmpty {}

class BannerLoadedState extends BannerState
    implements DataLoaded<List<BannerModel>> {
  final List<BannerModel> banners;

  BannerLoadedState({required this.banners});

  @override
  List<BannerModel> get data => banners;

  List<BannerModel> get activeBanners {
    final currentTime = DateTime.now();

    return banners.where((banner) {
      if (banner.expiresAt == null) return true;
      return banner.expiresAt!.isAfter(currentTime);
    }).toList();
  }

  List<BannerModel> get completedBanners {
    final currentTime = DateTime.now();

    return banners.where((banner) {
      if (banner.expiresAt == null) return false;
      return banner.expiresAt!.isBefore(currentTime) ||
          banner.expiresAt!.isAtSameMomentAs(currentTime);
    }).toList();
  }
}

class BannerErrorState extends BannerState implements DataError {
  final String message;
  BannerErrorState({required this.message});

  @override
  String get errorMessage => message;
}

class BannerToggleSuccess extends BannerState implements DataUpdated {}

class BannerItemsLoadingState extends BannerState {}

class BannerItemsLoadedState extends BannerState {
  final List<Map<String, dynamic>> items;
  BannerItemsLoadedState({required this.items});
}

class BannerDialogLoadingState extends BannerState {}

class BannerDeleteLoadingState extends BannerState {
  final String bannerId;
  BannerDeleteLoadingState({required this.bannerId});
}

class BannerAddedSuccess extends BannerState implements DataUpdated {}

class BannerUpdatedSuccess extends BannerState implements DataUpdated {}

class BannerDeletedSuccess extends BannerState implements DataUpdated {}
