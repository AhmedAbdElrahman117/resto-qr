import 'package:resto_qr/Core/Base%20State/base_state.dart';
import 'package:resto_qr/Feature/Home/Models/dashboard_stats_model.dart';
import 'package:resto_qr/Feature/Menu/Models/category_model.dart';
import 'package:resto_qr/Feature/Menu/Models/item_model.dart';
import 'package:resto_qr/Feature/Website/Banners/Models/banner_model.dart';

class HomeState {}

class HomeInitialState extends HomeState {}

class StatsLoadingState extends HomeState implements DataLoading {}

class StatsLoadedState extends HomeState implements DataLoaded {
  final DashboardStatsModel stats;

  StatsLoadedState({required this.stats});

  @override
  get data => stats;
}

class StatsErrorState extends HomeState implements DataError {
  final String message;

  StatsErrorState({required this.message});

  @override
  get errorMessage => message;
}

class TopItemsLoadingState extends HomeState implements DataLoading {}

class TopItemsLoadedState extends HomeState implements DataLoaded {
  final List<ItemModel> topItems;

  TopItemsLoadedState({required this.topItems});

  @override
  get data => topItems;
}

class TopItemsErrorState extends HomeState implements DataError {
  final String message;

  TopItemsErrorState({required this.message});

  @override
  get errorMessage => message;
}

class TopItemsEmptyState extends HomeState implements DataEmpty {}

class BannersLoadingState extends HomeState implements DataLoading {}

class BannersLoadedState extends HomeState implements DataLoaded {
  final List<BannerModel> banners;

  BannersLoadedState({required this.banners});

  @override
  get data => banners;
}

class BannersErrorState extends HomeState implements DataError {
  final String message;

  BannersErrorState({required this.message});

  @override
  get errorMessage => message;
}

class BannersEmptyState extends HomeState implements DataEmpty {}

class CategoriesLoadingState extends HomeState implements DataLoading {}

class CategoriesLoadedState extends HomeState implements DataLoaded {
  final List<CategoryModel> categories;

  CategoriesLoadedState({required this.categories});

  @override
  get data => categories;
}

class CategoriesErrorState extends HomeState implements DataError {
  final String message;

  CategoriesErrorState({required this.message});

  @override
  get errorMessage => message;
}

class CategoriesEmptyState extends HomeState implements DataEmpty {}
