import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Cubit/app_cubit.dart';
import 'package:resto_qr/Core/Models/app_settings.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Widgets/sliver_sized_box.dart';
import 'package:resto_qr/Feature/Settings/View%20Model/Profile%20Settings%20Cubit/profile_cubit.dart';
import 'package:resto_qr/Feature/Settings/Views/language_view.dart';
import 'package:resto_qr/Feature/Settings/Views/notification_settings_view.dart';
import 'package:resto_qr/Feature/Settings/Widgets/dark_mode_toggle.dart';
import 'package:resto_qr/Feature/Settings/Widgets/profile_settings.dart';
import 'package:resto_qr/Feature/Settings/Widgets/setting_option_tile.dart';

class AccountSettingOptions extends StatelessWidget {
  const AccountSettingOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: SettingOptionTile(
            title: l10n.profileDetails,
            icon: Icons.person,
            subtitle: l10n.profileDetailsDescription,
            onTap: () {
              Navigation().push(
                context,
                BlocProvider(
                  create: (context) => ProfileCubit(),
                  child: ProfileSettings(),
                ),
              );
            },
          ),
        ),

        SliverVisibility(
          visible: false,
          replacementSliver: SliverSizedBox(),
          sliver: SliverToBoxAdapter(
            child: SettingOptionTile(
              title: l10n.notificationSettings,
              icon: Icons.notifications_active,
              subtitle: l10n.manageNotificationPreferences,
              onTap: () {
                Navigation().push(context, const NotificationSettingsView());
              },
            ),
          ),
        ),

        const SliverSizedBox(height: 16),

        SliverToBoxAdapter(
          child: BlocSelector<AppCubit, AppSettings, String?>(
            selector: (state) => state.languageName,
            builder: (context, state) {
              return SettingOptionTile(
                title: l10n.language,
                icon: Icons.language,
                subtitle: state ?? l10n.defaultLanguage,
                onTap: () {
                  Navigation().push(context, LanguageView());
                },
              );
            },
          ),
        ),

        const SliverSizedBox(height: 16),

        const SliverToBoxAdapter(child: DarkModeToggle()),
      ],
    );
  }
}
