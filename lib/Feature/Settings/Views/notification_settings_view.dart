import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Cubit/app_cubit.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Widgets/info_box.dart';
import 'package:resto_qr/Core/Widgets/sliver_sized_box.dart';
import 'package:resto_qr/Feature/Settings/Widgets/notification_toggle.dart';

class NotificationSettingsView extends StatelessWidget {
  const NotificationSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: Text(l10n.notificationSettings),
            centerTitle: true,
            floating: true,
            snap: true,
          ),

          const SliverSizedBox(height: 16),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: InfoBox(
                    info: l10n.notificationSettingsDescription,
                  ),
                ),

                const SliverSizedBox(height: 32),

                SliverToBoxAdapter(
                  child: Text(
                    l10n.activityNotifications,
                    style: AppText().semiBold16(context),
                  ),
                ),

                const SliverSizedBox(height: 4),

                SliverToBoxAdapter(
                  child: Text(
                    l10n.menuInteractionsDescription,
                    style: AppText().caption(context),
                  ),
                ),

                const SliverSizedBox(height: 12),

                SliverToBoxAdapter(
                  child: NotificationToggle(
                    title: l10n.newMenuVisits,
                    subtitle: l10n.qrScanNotificationsDescription,
                    icon: Icons.visibility,
                    initialValue: context
                        .read<AppCubit>()
                        .state
                        .notificationSettings
                        .newVisits,
                    onToggle: (value) {
                      context.read<AppCubit>().updateNotificationSettings(
                        newVisits: value,
                      );
                    },
                  ),
                ),

                const SliverSizedBox(height: 32),

                SliverToBoxAdapter(
                  child: Text(
                    l10n.systemAndGrowth,
                    style: AppText().semiBold16(context),
                  ),
                ),

                const SliverSizedBox(height: 4),

                SliverToBoxAdapter(
                  child: Text(
                    l10n.platformUpdatesDescription,
                    style: AppText().caption(context),
                  ),
                ),

                const SliverSizedBox(height: 12),

                SliverToBoxAdapter(
                  child: NotificationToggle(
                    title: l10n.systemUpdates,
                    subtitle: l10n.securityPlatformUpdates,
                    icon: Icons.update,
                    initialValue: context
                        .read<AppCubit>()
                        .state
                        .notificationSettings
                        .appUpdates,
                    onToggle: (value) {
                      context.read<AppCubit>().updateNotificationSettings(
                        appUpdates: value,
                      );
                    },
                  ),
                ),

                const SliverSizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
