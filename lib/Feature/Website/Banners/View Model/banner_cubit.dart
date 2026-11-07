import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Cubit/safe_cubit.dart';
import 'package:resto_qr/Feature/Website/Banners/Models/banner_model.dart';
import 'package:resto_qr/Feature/Website/Banners/Repo/banner_repo.dart';
import 'package:resto_qr/Feature/Website/Banners/View%20Model/banner_state.dart';

class BannerCubit extends Cubit<BannerState> with SafeCubit {
  final String menuID;

  final BannerRepo _repo = BannerRepo();

  StreamSubscription? _bannersSubscription;

  BannerCubit({required this.menuID}) : super(BannerInitialState()) {
    getBanners();
  }

  void getBanners() async {
    safeEmit(BannerLoadingState());

    _bannersSubscription = _repo.stream.listen(
      (banners) => banners.isEmpty
          ? safeEmit(BannerEmptyState())
          : safeEmit(BannerLoadedState(banners: banners)),

      onError: (error) => safeEmit(BannerErrorState(message: error.toString())),
    );

    await _repo.getBanners(menuID: menuID);
  }

  void getMenuItems({required String ownerId}) async {
    safeEmit(BannerItemsLoadingState());

    final res = await _repo.getMenuItems(ownerId: ownerId);

    res.fold(
      (l) => safeEmit(BannerErrorState(message: l.message)),
      (r) => safeEmit(BannerItemsLoadedState(items: r)),
    );
  }

  void addBanner({required BannerModel banner, required String image}) async {
    safeEmit(BannerDialogLoadingState());

    final res = await _repo.addBanner(banner: banner, image: image);

    res.fold(
      (l) => safeEmit(BannerErrorState(message: l.message)),
      (r) => safeEmit(BannerAddedSuccess()),
    );
  }

  void updateBanner({required BannerModel banner, String? image}) async {
    safeEmit(BannerDialogLoadingState());

    final res = await _repo.updateBanner(banner: banner, image: image);

    res.fold(
      (l) => safeEmit(BannerErrorState(message: l.message)),
      (r) => safeEmit(BannerUpdatedSuccess()),
    );
  }

  void deleteBanner({required BannerModel banner}) async {
    safeEmit(BannerDeleteLoadingState(bannerId: banner.id));

    final res = await _repo.deleteBanner(banner: banner);

    res.fold(
      (l) => safeEmit(BannerErrorState(message: l.message)),
      (r) => safeEmit(BannerDeletedSuccess()),
    );
  }

  Future<void> toggleBannerActive(BannerModel banner) async {
    final res = await _repo.toggleBannerActive(banner: banner);

    res.fold(
      (l) => safeEmit(BannerErrorState(message: l.message)),
      (r) => safeEmit(BannerToggleSuccess()),
    );
  }

  @override
  Future<void> close() {
    _bannersSubscription?.cancel();
    return super.close();
  }
}
