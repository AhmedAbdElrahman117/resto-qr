import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Widgets/bloc_widget.dart';
import 'package:resto_qr/Core/Widgets/sliver_sized_box.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Login%20Cubit/login_cubit.dart';
import 'package:resto_qr/Feature/Menu/Models/category_model.dart';
import 'package:resto_qr/Feature/Menu/Models/item_model.dart';
import 'package:resto_qr/Feature/Home/View%20Model/Home%20Cubit/home_cubit.dart';
import 'package:resto_qr/Feature/Home/View%20Model/Home%20Cubit/home_state.dart';
import 'package:resto_qr/Feature/Home/View%20Model/Top%20Items%20Cubit/top_items_cubit.dart';
import 'package:resto_qr/Feature/Home/Views/top_items_view.dart';
import 'package:resto_qr/Feature/Home/Widgets/dashboard.dart';
import 'package:resto_qr/Feature/Home/Widgets/home_app_bar.dart';
import 'package:resto_qr/Feature/Home/Widgets/top_banners_card.dart';
import 'package:resto_qr/Feature/Home/Widgets/top_category_tile.dart';
import 'package:resto_qr/Feature/Home/Widgets/top_item_tile.dart';
import 'package:resto_qr/Feature/Website/Banners/Models/banner_model.dart';
import 'package:resto_qr/Feature/Website/Banners/View%20Model/banner_cubit.dart';
import 'package:resto_qr/Feature/Website/Banners/banner_management_page.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.bottomNavController});

  final PersistentTabController bottomNavController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 3,
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return Scaffold(
      body: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const .fromLTRB(16, 20, 16, 0),
              sliver: SliverToBoxAdapter(
                child: HomeAppBar(),
              ),
            ),

            const SliverSizedBox(height: 32),

            SliverPadding(
              padding: const .symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: Dashboard(tabController: _tabController),
              ),
            ),

            const SliverSizedBox(height: 32),

            SliverPadding(
              padding: const .symmetric(horizontal: 16),
              sliver: SliverMainAxisGroup(
                slivers: [
                  SliverToBoxAdapter(
                    child: sectionHeader(
                      context,
                      l10n.topItems,
                      () => Navigation().push(
                        context,
                        BlocProvider(
                          create: (context) => TopItemsCubit(
                            restaurantId: context
                                .read<LoginCubit>()
                                .state
                                .user
                                .restaurantID!,
                          ),
                          child: TopItemsView(),
                        ),
                      ),
                    ),
                  ),

                  const SliverSizedBox(height: 4),

                  SliverToBoxAdapter(
                    child: Text(
                      l10n.topItemsDescription,
                      style: AppText().caption(context),
                    ),
                  ),

                  const SliverSizedBox(height: 16),

                  BlocWidget<HomeCubit, HomeState>(
                    isSliver: true,
                    buildWhen: (prev, curr) =>
                        curr is TopItemsLoadingState ||
                        curr is TopItemsLoadedState ||
                        curr is TopItemsErrorState ||
                        curr is TopItemsEmptyState,
                    emptyBuilder: (context, state) => SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          l10n.noItemsFound,
                          style: AppText().caption(context),
                        ),
                      ),
                    ),
                    errorBuilder: (context, state) => SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          l10n.errorLoadingTopItems,
                          style: AppText().caption(context),
                        ),
                      ),
                    ),
                    loadingBuilder: (context, state) => loadingList(
                      child: TopItemTile(
                        rank: AppLocalization.formatNumber(1, context: context),
                        item: EmptyItemModel(),
                      ),
                    ),
                    childBuilder: (context, state) {
                      var data = state.data as List<ItemModel>;

                      return SliverList.separated(
                        itemCount: data.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (context, index) => TopItemTile(
                          rank: AppLocalization.formatNumber(
                            index + 1,
                            context: context,
                          ),
                          item: data[index],
                        ),
                      );
                    },
                  ),

                  const SliverSizedBox(height: 32),

                  SliverToBoxAdapter(
                    child: sectionHeader(
                      context,
                      l10n.activeBanners,
                      () => Navigation().push(
                        context,
                        BlocProvider(
                          create: (context) => BannerCubit(
                            menuID: context
                                .read<LoginCubit>()
                                .state
                                .user
                                .menuId!,
                          ),
                          child: BannerManagementPage(),
                        ),
                      ),
                    ),
                  ),

                  const SliverSizedBox(height: 4),

                  SliverToBoxAdapter(
                    child: Text(
                      l10n.activeBannersDescription,
                      style: AppText().caption(context),
                    ),
                  ),

                  const SliverSizedBox(height: 16),

                  BlocWidget<HomeCubit, HomeState>(
                    isSliver: true,
                    buildWhen: (prev, curr) =>
                        curr is BannersLoadingState ||
                        curr is BannersLoadedState ||
                        curr is BannersErrorState ||
                        curr is BannersEmptyState,
                    errorBuilder: (context, state) => SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          l10n.failedToLoadBanners,
                          style: AppText().caption(context),
                        ),
                      ),
                    ),
                    emptyBuilder: (context, state) => SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          l10n.noActiveBanners,
                          style: AppText().caption(context),
                        ),
                      ),
                    ),
                    loadingBuilder: (context, state) => SliverToBoxAdapter(
                      child: SizedBox(
                        height: 140,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: 5,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 24),
                          itemBuilder: (context, index) {
                            return Skeletonizer(
                              enabled: true,
                              containersColor: AppConstants().neonBlue
                                  .withValues(
                                    alpha: 0.5,
                                  ),
                              child: TopBannersCard(
                                banner: EmptyBannerModel(),
                                index: index + 1,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    childBuilder: (context, state) {
                      var data = state.data as List<BannerModel>;

                      return SliverToBoxAdapter(
                        child: SizedBox(
                          height: 140,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: data.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 24),
                            itemBuilder: (context, index) {
                              return TopBannersCard(
                                banner: data[index],
                                index: index + 1,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),

                  const SliverSizedBox(height: 32),

                  SliverToBoxAdapter(
                    child: sectionHeader(
                      context,
                      l10n.topCategories,
                      () {
                        widget.bottomNavController.jumpToTab(1);
                      },
                    ),
                  ),

                  const SliverSizedBox(height: 4),

                  SliverToBoxAdapter(
                    child: Text(
                      l10n.topCategoriesDescription,
                      style: AppText().caption(context),
                    ),
                  ),

                  const SliverSizedBox(height: 16),

                  BlocWidget<HomeCubit, HomeState>(
                    isSliver: true,
                    buildWhen: (prev, curr) =>
                        curr is CategoriesLoadingState ||
                        curr is CategoriesLoadedState ||
                        curr is CategoriesErrorState ||
                        curr is CategoriesEmptyState,
                    emptyBuilder: (context, state) => SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          l10n.noCategoriesFound,
                          style: AppText().caption(context),
                        ),
                      ),
                    ),
                    errorBuilder: (context, state) => SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          l10n.failedToLoadCategories,
                          style: AppText().caption(context),
                        ),
                      ),
                    ),
                    loadingBuilder: (context, state) => loadingList(
                      child: TopCategoryTile(
                        category: EmptyCategoryModel(),
                        rank: AppLocalization.formatNumber(1, context: context),
                      ),
                    ),
                    childBuilder: (context, state) {
                      var data = state.data as List<CategoryModel>;

                      return SliverList.separated(
                        itemCount: data.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (context, index) => TopCategoryTile(
                          category: data[index],
                          rank: AppLocalization.formatNumber(
                            index + 1,
                            context: context,
                          ),
                        ),
                      );
                    },
                  ),

                  const SliverSizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loadingList({required Widget child}) {
    return Skeletonizer.sliver(
      enabled: true,
      child: SliverList.separated(
        itemCount: 5,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) => child,
      ),
    );
  }

  Widget sectionHeader(
    BuildContext context,
    String title,
    void Function() onPressed,
  ) {
    return Row(
      children: [
        Text(
          title,
          style: AppText().semiBold18(context),
        ),

        const Spacer(),

        _buildShowAllButton(context, onPressed),
      ],
    );
  }

  Widget _buildShowAllButton(BuildContext context, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppConstants().neonBlue,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        AppLocalization.of(context).showAll,
        style: AppText().semiBold14(context, AppConstants().neonBlue),
      ),
    );
  }
}
