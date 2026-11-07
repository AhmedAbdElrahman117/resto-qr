import 'package:dartz/dartz.dart';
import 'package:resto_qr/Core/Models/app_exception.dart';
import 'package:resto_qr/Core/Services/supabase_db.dart';
import 'package:resto_qr/Core/Utils/stream_wrapper.dart';
import 'package:resto_qr/Feature/Website/Models/menu_theme_model.dart';

class WebsiteCustomizeRepo {
  WebsiteCustomizeRepo._();

  static WebsiteCustomizeRepo? _instance;

  factory WebsiteCustomizeRepo() => _instance ??= WebsiteCustomizeRepo._();

  final StreamWrapper<MenuThemeModel> _streamWrapper = StreamWrapper();

  Stream<MenuThemeModel> get stream => _streamWrapper.stream;

  MenuThemeModel _menuTheme = MenuThemeModel();

  final SupabaseDb _db = SupabaseDb();

  Future<Either<AppException, Unit>> get(String menuID) async {
    try {
      final res = await _db
          .get(table: 'menu_theme')
          .eq('menu_id', menuID)
          .timeout(const .new(seconds: 15));

      if (res.isNotEmpty) {
        _menuTheme = MenuThemeModel.fromMap(res.first);
        _streamWrapper.update(_menuTheme);
      }

      return right(unit);
    } catch (e, stackTrace) {
      return left(ExceptionHandler.handle(error: e, stackTrace: stackTrace));
    }
  }

  Future<Either<AppException, Unit>> update(
    MenuThemeModel theme,
  ) async {
    try {
      await _db
          .update(
            table: 'menu_theme',
            id: theme.id!,
            data: theme.toMap(),
          )
          .timeout(const .new(seconds: 15));

      _menuTheme = theme;
      _streamWrapper.update(_menuTheme);

      return right(unit);
    } catch (e, stackTrace) {
      return left(ExceptionHandler.handle(error: e, stackTrace: stackTrace));
    }
  }
}
