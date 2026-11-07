import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Login%20Cubit/login_cubit.dart';
import 'package:resto_qr/Feature/Home/View%20Model/Home%20Cubit/home_cubit.dart';
import 'package:resto_qr/Feature/Home/Views/home_page.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Category%20Cubit/category_cubit.dart';
import 'package:resto_qr/Feature/Qr/View%20Model/QR%20Code%20Cubit/qr_code_cubit.dart';
import 'package:resto_qr/Feature/Menu/Views/my_menu_page.dart';
import 'package:resto_qr/Feature/Qr/Views/qr_code_page.dart';
import 'package:resto_qr/Feature/Settings/Views/profile_page.dart';
import 'package:resto_qr/Feature/Website/View%20Model/website_cubit.dart';
import 'package:resto_qr/Feature/Website/website_customization_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PersistentTabController _tabController = PersistentTabController();

  late final String restaurantId;
  late final String menuId;
  late final String menuUrl;

  @override
  void initState() {
    var loginState = context.read<LoginCubit>().state.user;

    restaurantId = loginState.restaurantID!;

    menuId = loginState.menuId!;

    menuUrl = loginState.menuUrl!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    final navItems = {
      l10n.home: Icons.home,
      l10n.myMenu: Icons.menu_book,
      l10n.qrCode: Icons.qr_code,
      l10n.website: Icons.web,
      l10n.profile: Icons.person,
    };
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _tabController,
        backgroundColor: AppTheme().primaryBackground(context),
        decoration: NavBarDecoration(
          border: .all(
            color: AppTheme().borderColor(context),
            width: 1.5,
          ),
        ),
        items: navItems.entries.indexed
            .map(
              (e) => PersistentBottomNavBarItem(
                title: e.$2.key,
                icon: Icon(
                  e.$2.value,
                  color: e.$1 == 2 ? Colors.white : null,
                ),
                activeColorPrimary: AppConstants().neonBlue,
                inactiveColorPrimary: AppTheme().iconColor(context),
              ),
            )
            .toList(),
        screens: [
          BlocProvider(
            create: (context) =>
                HomeCubit(restaurantId: restaurantId, menuId: menuId),
            child: HomePage(bottomNavController: _tabController),
          ),
          BlocProvider(
            create: (context) => CategoryCubit(menuID: menuId),
            child: MyMenuPage(),
          ),
          BlocProvider(
            create: (context) => QrCodeCubit(menuUrl: menuUrl),
            child: QrCodePage(),
          ),
          BlocProvider(
            create: (context) => WebsiteCubit(menuID: menuId),
            child: WebsiteCustomizationPage(),
          ),
          ProfilePage(),
        ],
        navBarStyle: .style15,
        resizeToAvoidBottomInset: true,
        margin: .zero,
        padding: .zero,
      ),
    );
  }
}
