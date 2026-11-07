import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Cubit/safe_cubit.dart';
import 'package:resto_qr/Feature/Home/Repo/home_repo.dart';
import 'package:resto_qr/Feature/Home/View%20Model/Home%20Cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> with SafeCubit {
  HomeCubit({required this.restaurantId, required this.menuId})
    : super(HomeInitialState()) {
    Future.wait([
      getStats(menuId: menuId),
      getTop5Items(restaurantId: restaurantId),
      getActiveBanners(menuId: menuId),
      getTop5Categories(menuId: menuId),
    ]);
  }

  final String restaurantId;
  final String menuId;

  final HomeRepo _homeRepo = HomeRepo();

  Future<void> getStats({required String menuId}) async {
    safeEmit(StatsLoadingState());

    final result = await _homeRepo.getStats(menuId: menuId);

    result.fold(
      (error) => safeEmit(StatsErrorState(message: error.message)),
      (data) => safeEmit(StatsLoadedState(stats: data)),
    );
  }

  Future<void> getTop5Items({required String restaurantId}) async {
    safeEmit(TopItemsLoadingState());

    final result = await _homeRepo.getTop5Items(restaurantId: restaurantId);

    result.fold(
      (error) => safeEmit(TopItemsErrorState(message: error.message)),
      (data) => data.isEmpty
          ? safeEmit(TopItemsEmptyState())
          : safeEmit(TopItemsLoadedState(topItems: data)),
    );
  }

  Future<void> getActiveBanners({required String menuId}) async {
    safeEmit(BannersLoadingState());

    final result = await _homeRepo.getActiveBanners(menuId: menuId);

    result.fold(
      (error) => safeEmit(BannersErrorState(message: error.message)),
      (data) => data.isEmpty
          ? safeEmit(BannersEmptyState())
          : safeEmit(BannersLoadedState(banners: data)),
    );
  }

  Future<void> getTop5Categories({required String menuId}) async {
    safeEmit(CategoriesLoadingState());

    final result = await _homeRepo.getTop5Categories(menuId: menuId);

    result.fold(
      (error) => safeEmit(CategoriesErrorState(message: error.message)),
      (data) => data.isEmpty
          ? safeEmit(CategoriesEmptyState())
          : safeEmit(CategoriesLoadedState(categories: data)),
    );
  }
}
