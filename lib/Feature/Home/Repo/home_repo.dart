import 'package:dartz/dartz.dart';
import 'package:resto_qr/Core/Models/app_exception.dart';
import 'package:resto_qr/Core/Services/supabase_db.dart';
import 'package:resto_qr/Core/Services/supabase_rpc.dart';
import 'package:resto_qr/Feature/Home/Models/dashboard_stats_model.dart';
import 'package:resto_qr/Feature/Menu/Models/category_model.dart';
import 'package:resto_qr/Feature/Menu/Models/item_model.dart';
import 'package:resto_qr/Feature/Website/Banners/Models/banner_model.dart';

class HomeRepo {
  HomeRepo._();

  static final HomeRepo _instance = HomeRepo._();

  factory HomeRepo() => _instance;

  final _supabase = SupabaseDb();

  final _rpc = SupabaseRpc();

  Future<Either<AppException, DashboardStatsModel>> getStats({
    required String menuId,
  }) async {
    try {
      final response = await _rpc
          .call(
            function: 'get_all_standard_stats',
            params: {'p_menu_id': menuId},
          )
          .timeout(const .new(seconds: 15));

      var data = (response as Map<String, dynamic>);

      final statsModels = DashboardStatsModel.fromMap(data);

      return right(statsModels);
    } catch (e, stackTrace) {
      return left(ExceptionHandler.handle(error: e, stackTrace: stackTrace));
    }
  }

  /// Fetches the top 5 most viewed items for a specific restaurant.
  Future<Either<AppException, List<ItemModel>>> getTop5Items({
    required String restaurantId,
  }) async {
    try {
      final response = await _supabase
          .get(table: 'menu_items')
          .eq('restaurant_id', restaurantId)
          .order('views_count', ascending: false)
          .limit(5)
          .select()
          .timeout(const .new(seconds: 15));

      final items = (response as List);

      final itemModels = items
          .map((item) => ItemModel.fromMap(item as Map<String, dynamic>))
          .toList();

      return right(itemModels);
    } catch (e, stackTrace) {
      return left(ExceptionHandler.handle(error: e, stackTrace: stackTrace));
    }
  }

  /// Fetches all active/live banners for a specific menu.
  Future<Either<AppException, List<BannerModel>>> getActiveBanners({
    required String menuId,
  }) async {
    try {
      final response = await _rpc
          .call(
            function: 'get_active_banners',
            params: {'p_menu_id': menuId},
          )
          .timeout(const .new(seconds: 15));

      final bannerModels = (response as List)
          .map((banner) => BannerModel.fromMap(banner as Map<String, dynamic>))
          .toList();

      return right(bannerModels);
    } catch (e, stackTrace) {
      return left(ExceptionHandler.handle(error: e, stackTrace: stackTrace));
    }
  }

  /// Fetches the top 5 categories based on the count of items in them.
  Future<Either<AppException, List<CategoryModel>>> getTop5Categories({
    required String menuId,
  }) async {
    try {
      final response = await _supabase
          .get(table: 'categories')
          .eq('menu_id', menuId)
          .order('items_count', ascending: false)
          .limit(5)
          .select()
          .timeout(const .new(seconds: 15));

      final categoryModels = (response as List)
          .map(
            (category) =>
                CategoryModel.fromMap(category as Map<String, dynamic>),
          )
          .toList();

      return right(categoryModels);
    } catch (e, stackTrace) {
      return left(ExceptionHandler.handle(error: e, stackTrace: stackTrace));
    }
  }
}
