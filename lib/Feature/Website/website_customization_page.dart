import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Utils/assets.dart';
import 'package:resto_qr/Core/Utils/toast.dart';
import 'package:resto_qr/Core/Widgets/bloc_widget.dart';
import 'package:resto_qr/Core/Widgets/counter_widget.dart';
import 'package:resto_qr/Core/Widgets/empty_state_widget.dart';
import 'package:resto_qr/Core/Widgets/info_box.dart';
import 'package:resto_qr/Core/Widgets/sliver_sized_box.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Login%20Cubit/login_cubit.dart';
import 'package:resto_qr/Feature/Website/Banners/View%20Model/banner_cubit.dart';
import 'package:resto_qr/Feature/Website/Models/component_model.dart';
import 'package:resto_qr/Feature/Website/View%20Model/website_cubit.dart';
import 'package:resto_qr/Feature/Website/View%20Model/website_state.dart';
import 'package:resto_qr/Feature/Website/Widgets/component_card.dart';
import 'package:resto_qr/Feature/Website/background_color_preview.dart';
import 'package:resto_qr/Feature/Website/card_radius_preview.dart';
import 'package:resto_qr/Feature/Website/font_style_preview.dart';
import 'package:resto_qr/Feature/Website/primary_color_preview.dart';
import 'package:resto_qr/Feature/Website/Banners/banner_management_page.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WebsiteCustomizationPage extends StatefulWidget {
  const WebsiteCustomizationPage({super.key});

  @override
  State<WebsiteCustomizationPage> createState() =>
      _WebsiteCustomizationPageState();
}

class _WebsiteCustomizationPageState extends State<WebsiteCustomizationPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    final List<ComponentModel> promotions = [
      ComponentModel(
        name: l10n.promotionalBanners,
        description: l10n.managePromotionalBanners,
        image: Assets.imagesPromotionSpeaker,
        preview: BlocProvider(
          create: (context) => BannerCubit(
            menuID: context.read<LoginCubit>().state.user.menuId!,
          ),
          child: BannerManagementPage(),
        ),
      ),
    ];
    final List<ComponentModel> components = [
      ComponentModel(
        name: l10n.brandPrimaryColor,
        description: l10n.customizeBrandPrimaryColor,
        image: Assets.imagesPrimaryColor,
        preview: PrimaryColorPreview(),
      ),

      ComponentModel(
        name: l10n.backgroundColor,
        description: l10n.customizeWebsiteBackground,
        image: Assets.imagesColorPalette,
        preview: BackgroundColorPreview(),
      ),

      ComponentModel(
        name: l10n.fontStyle,
        description: l10n.customizeWebsiteFont,
        image: Assets.imagesFontSize,
        color: AppTheme().primaryText(context),
        preview: FontStylePreview(),
      ),

      ComponentModel(
        name: l10n.cardsRadius,
        description: l10n.customizeCardRadius,
        image: Assets.imagesBorderRadius,
        color: AppTheme().primaryText(context),
        preview: CardRadiusPreview(),
      ),
    ];

    return BlocListener<WebsiteCubit, WebsiteState>(
      listener: _listener,
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              title: Text(l10n.websiteCustomization),
              centerTitle: true,
              floating: true,
              snap: true,
            ),

            SliverSizedBox(height: 16),

            SliverPadding(
              padding: .symmetric(horizontal: 16),
              sliver: SliverMainAxisGroup(
                slivers: [
                  SliverToBoxAdapter(
                    child: Row(
                      crossAxisAlignment: .center,
                      children: [
                        Text(
                          l10n.marketingAndPromotions,
                          style: AppText().semiBold18(context),
                        ),

                        const Spacer(),

                        BlocWidget<WebsiteCubit, WebsiteState>(
                          buildWhen: (prev, curr) =>
                              curr is! WebsiteUpdatedState,
                          builder: (context, state) {
                            return Skeletonizer(
                              enabled: state is WebsiteLoadingState,
                              enableSwitchAnimation: true,
                              child: CounterWidget(count: promotions.length),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SliverSizedBox(height: 6),

                  SliverToBoxAdapter(
                    child: Text(
                      l10n.dynamicContentDescription,
                      style: AppText().caption(context),
                    ),
                  ),

                  const SliverSizedBox(height: 16),

                  BlocWidget<WebsiteCubit, WebsiteState>(
                    isSliver: true,
                    buildWhen: (prev, curr) => curr is! WebsiteUpdatedState,
                    builder: (context, state) {
                      return Skeletonizer.sliver(
                        enabled: state is WebsiteLoadingState,
                        child: SliverList.separated(
                          itemCount: promotions.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) =>
                              ComponentCard(component: promotions[index]),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SliverSizedBox(height: 32),

            SliverPadding(
              padding: .symmetric(horizontal: 16),
              sliver: SliverMainAxisGroup(
                slivers: [
                  SliverToBoxAdapter(
                    child: Row(
                      crossAxisAlignment: .center,
                      children: [
                        Text(
                          l10n.components,
                          style: AppText().semiBold18(context),
                        ),

                        const Spacer(),

                        BlocWidget<WebsiteCubit, WebsiteState>(
                          buildWhen: (prev, curr) =>
                              curr is! WebsiteUpdatedState,
                          builder: (context, state) {
                            return Skeletonizer(
                              enabled: state is WebsiteLoadingState,
                              enableSwitchAnimation: true,
                              child: CounterWidget(count: components.length),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SliverSizedBox(height: 6),

                  SliverToBoxAdapter(
                    child: Text(
                      l10n.personalizeMenuDescription,
                      style: AppText().caption(context),
                    ),
                  ),

                  const SliverSizedBox(height: 16),

                  SliverToBoxAdapter(
                    child: InfoBox(
                      info: l10n.moreComponentsInfo,
                    ),
                  ),

                  const SliverSizedBox(height: 24),
                ],
              ),
            ),

            SliverPadding(
              padding: .symmetric(horizontal: 16),
              sliver: BlocWidget<WebsiteCubit, WebsiteState>(
                isSliver: true,
                buildWhen: (prev, curr) => curr is! WebsiteUpdatedState,
                builder: (context, state) {
                  if (state is WebsiteErrorState) {
                    return SliverToBoxAdapter(
                      child: EmptyStateWidget(
                        title: l10n.error,
                        message: l10n.failedToLoadCustomizations,
                      ),
                    );
                  } else {
                    return Skeletonizer.sliver(
                      enabled: state is WebsiteLoadingState,
                      child: SliverList.separated(
                        itemCount: components.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 16),
                        itemBuilder: (context, index) =>
                            ComponentCard(component: components[index]),
                      ),
                    );
                  }
                },
              ),
            ),
            const SliverSizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _listener(BuildContext context, state) {
    if (state is WebsiteUpdatedState) {
      Toast().showSuccess(
        title: AppLocalization.of(context).websiteUpdatedSuccessfully,
        description: AppLocalization.of(context).websiteChangesSaved,
      );
    } else if (state is WebsiteErrorState) {
      Toast().showError(
        title: AppLocalization.of(context).error,
        description: state.message,
      );
    }
  }
}
