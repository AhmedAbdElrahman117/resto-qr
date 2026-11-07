import 'package:resto_qr/Core/Base%20State/base_state.dart';
import 'package:resto_qr/Feature/Website/Models/menu_theme_model.dart';

class WebsiteState {}

class WebsiteInitialState extends WebsiteState {}

class WebsiteLoadingState extends WebsiteState implements DataLoading {}

class WebsiteErrorState extends WebsiteState implements DataError {
  final String message;

  WebsiteErrorState({required this.message});

  @override
  String get errorMessage => message;
}

class WebsiteUpdatedState extends WebsiteState {}

class WebsiteLoadedState extends WebsiteState
    implements DataLoaded<MenuThemeModel> {
  final MenuThemeModel theme;

  WebsiteLoadedState({required this.theme});

  @override
  MenuThemeModel get data => theme;
}
