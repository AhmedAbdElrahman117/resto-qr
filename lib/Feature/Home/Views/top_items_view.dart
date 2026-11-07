import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/assets.dart';
import 'package:resto_qr/Core/Widgets/bloc_widget.dart';
import 'package:resto_qr/Core/Widgets/counter_widget.dart';
import 'package:resto_qr/Core/Widgets/empty_state_widget.dart';
import 'package:resto_qr/Core/Widgets/sliver_sized_box.dart';
import 'package:resto_qr/Feature/Menu/Models/item_model.dart';
import 'package:resto_qr/Feature/Home/View%20Model/Top%20Items%20Cubit/top_items_cubit.dart';
import 'package:resto_qr/Feature/Home/View%20Model/Top%20Items%20Cubit/top_items_state.dart';
import 'package:resto_qr/Feature/Home/Widgets/top_item_tile.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TopItemsView extends StatelessWidget {
  const TopItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: Text(l10n.topItems),
            centerTitle: true,
            floating: true,
            snap: true,
          ),

          const SliverSizedBox(height: 16),

          SliverPadding(
            padding: const .symmetric(horizontal: 16),
            sliver: SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Text(
                        l10n.leaderboard,
                        style: AppText().semiBold18(context),
                      ),

                      const Spacer(),

                      BlocWidget<TopItemsCubit, TopItemsState>(
                        builder: (context, state) {
                          int count = state is TopItemsLoadedState
                              ? state.topItems.length
                              : 0;

                          return Skeletonizer(
                            enabled: state is TopItemsLoadingState,
                            enableSwitchAnimation: true,
                            child: CounterWidget(count: count),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SliverSizedBox(height: 6),

                SliverToBoxAdapter(
                  child: Text(
                    l10n.leaderboardDescription,
                    style: AppText().caption(context),
                  ),
                ),

                const SliverSizedBox(height: 16),

                BlocWidget<TopItemsCubit, TopItemsState>(
                  isSliver: true,
                  builder: (context, state) {
                    if (state is TopItemsEmptyState) {
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: EmptyStateWidget(
                          title: l10n.noItems,
                          message: l10n.noItemsToDisplay,
                        ),
                      );
                    } else if (state is TopItemsErrorState) {
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: EmptyStateWidget(
                          title: l10n.error,
                          message: state.message,
                          image: Assets.imagesError,
                        ),
                      );
                    }

                    var data = state is TopItemsLoadedState
                        ? state.topItems
                        : List.generate(
                            20,
                            (index) => EmptyItemModel(),
                          );

                    return Skeletonizer.sliver(
                      enabled: state is TopItemsLoadingState,
                      child: SliverList.separated(
                        itemCount: data.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (context, index) => TopItemTile(
                          item: data[index],
                          rank: '${index + 1}',
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
    );
  }
}
