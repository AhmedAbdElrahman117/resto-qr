import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resto_qr/Core/Dialogs/general_dialog.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_extensions.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Widgets/universal_image.dart';
import 'package:resto_qr/Core/Utils/app_dialogs.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Login%20Cubit/login_cubit.dart';
import 'package:resto_qr/Feature/Website/Banners/Models/banner_model.dart';
import 'package:resto_qr/Feature/Website/Banners/View%20Model/banner_cubit.dart';
import 'package:resto_qr/Feature/Website/Banners/Widgets/add_banner_dialog.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BannerListCard extends StatefulWidget {
  final BannerModel banner;

  const BannerListCard({
    super.key,
    required this.banner,
  });

  @override
  State<BannerListCard> createState() => _BannerListCardState();
}

class _BannerListCardState extends State<BannerListCard> {
  late final ValueNotifier<bool?> isLive;

  bool isLoading = false;

  @override
  void initState() {
    isLive = ValueNotifier(widget.banner.isLive);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme().primaryBackground(context),
          borderRadius: .circular(16),
          border: .all(color: AppTheme().borderColor(context)),
        ),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const .vertical(top: .circular(15)),
                  child: SizedBox(
                    width: .infinity,
                    height: 200,
                    child: UniversalImage(source: widget.banner.imageUrl),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: statusBill(),
                ),
              ],
            ),
            Padding(
              padding: const .all(16),
              child: Row(
                crossAxisAlignment: .center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        redirectLink(context),

                        const SizedBox(height: 8),

                        clicksCount(context),

                        if (widget.banner.expiresAt != null) ...[
                          const SizedBox(height: 8),
                          expireAtWidget(context),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),

                  _hideButton(context),

                  const SizedBox(width: 16),

                  editBanner(),

                  const SizedBox(width: 8),

                  deleteBanner(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ValueListenableBuilder<bool?> statusBill() {
    return ValueListenableBuilder<bool?>(
      valueListenable: isLive,
      builder: (context, value, _) {
        final isNull = value == null;
        final isLiveVal = value == true;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: isNull
                ? AppConstants().neonBlue
                : isLiveVal
                ? Colors.green
                : AppConstants().errorRed,
            borderRadius: .circular(12),
          ),
          child: AnimatedSize(
            duration: const .new(milliseconds: 200),
            curve: Curves.easeInOut,
            child: AnimatedSwitcher(
              duration: const .new(milliseconds: 200),
              child: Row(
                key: ValueKey<String>(
                  isNull
                      ? 'updating'
                      : isLiveVal
                      ? 'live'
                      : 'hidden',
                ),
                mainAxisSize: .min,
                children: [
                  if (isNull)
                    const Padding(
                      padding: .only(right: 6),
                      child: SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  Text(
                    isNull
                        ? AppLocalization.of(context).updating
                        : isLiveVal
                        ? AppLocalization.of(context).live
                        : AppLocalization.of(context).hidden,
                    style: AppText()
                        .caption(context)
                        .copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget deleteBanner(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppConstants().errorRed.withValues(alpha: 0.1),
        shape: .circle,
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
              message: AppLocalization.of(context).deleteBannerConfirmation,
              onConfirm: (dialogContext) {
                Navigation().pop(dialogContext);
                context.read<BannerCubit>().deleteBanner(banner: widget.banner);
              },
            ),
          );
        },
      ),
    );
  }

  Widget editBanner() {
    return Container(
      decoration: BoxDecoration(
        color: AppConstants().neonBlue.withValues(alpha: 0.1),
        shape: .circle,
      ),
      child: IconButton(
        icon: Icon(
          Icons.edit_outlined,
          color: AppConstants().neonBlue,
          size: 20,
        ),
        onPressed: () {
          AppDialogs().showDialog(
            context: context,
            child: AddBannerDialog(
              cubit: context.read<BannerCubit>(),
              menuId: widget.banner.menuId,
              ownerId: context.read<LoginCubit>().state.user.id!,
              currentBanner: widget.banner,
            ),
          );
        },
      ),
    );
  }

  Widget redirectLink(BuildContext context) {
    return Row(
      children: [
        Icon(
          widget.banner.redirectUrl?.isNotEmpty == true
              ? Icons.link
              : Icons.link_off,
          size: 16,
          color: widget.banner.redirectUrl?.isNotEmpty == true
              ? AppTheme().primaryText(context)
              : AppTheme().secondaryText(context),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            widget.banner.redirectUrl?.isNotEmpty == true
                ? widget.banner.redirectUrl!
                : AppLocalization.of(context).noRedirectLink,
            style: AppText()
                .caption(context)
                .copyWith(
                  color: widget.banner.redirectUrl?.isNotEmpty == true
                      ? AppTheme().primaryText(context)
                      : AppTheme().secondaryText(context),
                ),
            maxLines: 1,
            overflow: .ellipsis,
          ),
        ),
      ],
    );
  }

  Widget clicksCount(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.touch_app_outlined,
          size: 16,
          color: AppConstants().neonBlue,
        ),
        const SizedBox(width: 8),
        Text(
          AppLocalization.of(context).clicks(widget.banner.interactions),
          style: AppText()
              .caption(context)
              .copyWith(
                color: AppConstants().neonBlue,
                fontWeight: .w600,
              ),
        ),
      ],
    );
  }

  Widget expireAtWidget(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.history_toggle_off,
          size: 16,
          color:
              widget.banner.expiresAt!.isBefore(
                DateTime.now(),
              )
              ? AppConstants().errorRed
              : AppTheme().secondaryText(context),
        ),
        const SizedBox(width: 8),
        Text(
          AppLocalization.of(context).expires(
            widget.banner.expiresAt!.toDateTimeShort(),
          ),
          style: AppText()
              .caption(context)
              .copyWith(
                color:
                    widget.banner.expiresAt!.isBefore(
                      DateTime.now(),
                    )
                    ? AppConstants().errorRed
                    : AppTheme().secondaryText(context),
                fontWeight:
                    widget.banner.expiresAt!.isBefore(
                      DateTime.now(),
                    )
                    ? .w600
                    : .normal,
              ),
        ),
      ],
    );
  }

  Widget _hideButton(BuildContext context) {
    return ValueListenableBuilder<bool?>(
      valueListenable: isLive,
      builder: (context, value, _) {
        return IconButton(
          onPressed: value == null
              ? null
              : () async {
                  final currentState = isLive.value!;
                  isLive.value = null;

                  try {
                    await context.read<BannerCubit>().toggleBannerActive(
                      widget.banner,
                    );
                    isLive.value = !currentState;
                  } catch (e) {
                    isLive.value = currentState;
                  }
                },
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: value == null
                ? const SizedBox(
                    key: ValueKey('loading'),
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : value
                ? const FaIcon(
                    FontAwesomeIcons.eye,
                    key: ValueKey('eye'),
                    size: 20,
                  )
                : const FaIcon(
                    FontAwesomeIcons.eyeSlash,
                    key: ValueKey('slash'),
                    size: 20,
                  ),
          ),
          style: IconButton.styleFrom(
            backgroundColor: AppTheme()
                .iconColor(context)
                .withValues(alpha: 0.12),
            foregroundColor: AppTheme().iconColor(context),
            disabledBackgroundColor: AppTheme()
                .iconColor(context)
                .withValues(alpha: 0.12),
            disabledForegroundColor: AppTheme()
                .iconColor(context)
                .withValues(alpha: 0.5),
            shape: RoundedRectangleBorder(
              borderRadius: .circular(80),
            ),
            padding: const .symmetric(vertical: 12, horizontal: 16),
          ),
        );
      },
    );
  }
}
