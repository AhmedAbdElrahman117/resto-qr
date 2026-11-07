import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Dialogs/general_dialog.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_dialogs.dart';
import 'package:resto_qr/Core/Utils/app_extensions.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Widgets/universal_image.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Login%20Cubit/login_cubit.dart';
import 'package:resto_qr/Feature/Website/Banners/Models/banner_model.dart';
import 'package:resto_qr/Feature/Website/Banners/View%20Model/banner_cubit.dart';
import 'package:resto_qr/Feature/Website/Banners/Widgets/add_banner_dialog.dart';

class CompletedBannerCard extends StatelessWidget {
  final BannerModel banner;

  const CompletedBannerCard({
    super.key,
    required this.banner,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme().primaryBackground(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme().borderColor(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: UniversalImage(source: banner.imageUrl),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme().secondaryText(context),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    AppLocalization.of(context).expired,
                    style: AppText()
                        .caption(context)
                        .copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.touch_app_outlined,
                            size: 16,
                            color: AppConstants().neonBlue,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            AppLocalization.of(context).totalClicks(
                              banner.interactions,
                            ),
                            style: AppText()
                                .caption(context)
                                .copyWith(
                                  color: AppConstants().neonBlue,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.history,
                            size: 16,
                            color: AppTheme().secondaryText(context),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            AppLocalization.of(context).ended(
                              banner.expiresAt!.toDateTimeShort(),
                            ),
                            style: AppText()
                                .caption(context)
                                .copyWith(
                                  color: AppTheme().secondaryText(context),
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // Republish Button
                Container(
                  decoration: BoxDecoration(
                    color: AppConstants().neonBlue.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: AppConstants().neonBlue,
                      size: 20,
                    ),
                    onPressed: () {
                      AppDialogs().showDialog(
                        context: context,
                        child: AddBannerDialog(
                          cubit: context.read<BannerCubit>(),
                          menuId: banner.menuId,
                          ownerId: context.read<LoginCubit>().state.user.id!,
                          currentBanner: banner,
                        ),
                      );
                    },
                    tooltip: AppLocalization.of(context).republishBanner,
                  ),
                ),
                const SizedBox(width: 8),

                // Delete Button
                Container(
                  decoration: BoxDecoration(
                    color: AppConstants().errorRed.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: AppConstants().errorRed,
                      size: 20,
                    ),
                    onPressed: () {
                      AppDialogs().showDialog(
                        context: context,
                        child: GeneralDialog(
                          title: AppLocalization.of(context).deleteBanner,
                          message: AppLocalization.of(
                            context,
                          ).deleteExpiredBannerConfirmation,
                          onConfirm: (dialogContext) {
                            Navigation().pop(dialogContext);
                            context.read<BannerCubit>().deleteBanner(
                              banner: banner,
                            );
                          },
                        ),
                      );
                    },
                    tooltip: AppLocalization.of(context).deleteBanner,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
