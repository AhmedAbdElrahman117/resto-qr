import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Cubit/safe_cubit.dart';
import 'package:resto_qr/Feature/Website/Models/menu_theme_model.dart';
import 'package:resto_qr/Feature/Website/Repo/website_customize_repo.dart';
import 'package:resto_qr/Feature/Website/View%20Model/website_state.dart';

class WebsiteCubit extends Cubit<WebsiteState> with SafeCubit {
  WebsiteCubit({required this.menuID}) : super(WebsiteInitialState()) {
    get();
  }

  final String menuID;

  final WebsiteCustomizeRepo _repo = WebsiteCustomizeRepo();

  MenuThemeModel currentTheme = MenuThemeModel();

  StreamSubscription? _themeSubscription;

  void get() async {
    safeEmit(WebsiteLoadingState());

    _themeSubscription = _repo.stream.listen(
      (theme) {
        currentTheme = theme;
        safeEmit(WebsiteLoadedState(theme: theme));
      },
      onError: (error) => safeEmit(WebsiteErrorState(message: error)),
    );

    await _repo.get(menuID);
  }

  void update({
    Color? primaryColor,
    Color? backgroundColor,
    String? fontFamily,
    int? cardRadius,
    int? cardElevation,
  }) async {
    safeEmit(WebsiteLoadingState());

    currentTheme = currentTheme.copyWith(
      primaryColor: primaryColor,
      backgroundColor: backgroundColor,
      fontFamily: fontFamily,
      cardRadius: cardRadius,
      cardElevation: cardElevation,
    );

    final res = await _repo.update(currentTheme);

    res.fold(
      (l) => safeEmit(WebsiteErrorState(message: l.message)),
      (r) => safeEmit(WebsiteUpdatedState()),
    );
  }

  @override
  Future<void> close() {
    _themeSubscription?.cancel();
    return super.close();
  }
}
