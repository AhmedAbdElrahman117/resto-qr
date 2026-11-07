import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/assets.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Utils/toast.dart';
import 'package:resto_qr/Core/Widgets/bloc_widget.dart';
import 'package:resto_qr/Core/Widgets/counter_widget.dart';
// import 'package:resto_qr/Core/Widgets/custom_text_field.dart';
import 'package:resto_qr/Core/Widgets/empty_state_widget.dart';
import 'package:resto_qr/Core/Widgets/sliver_sized_box.dart';
import 'package:resto_qr/Feature/Menu/Models/item_model.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Item%20Cubit/item_cubit.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Item%20Cubit/item_states.dart';
import 'package:resto_qr/Feature/Menu/Views/add_item_view.dart';
import 'package:resto_qr/Feature/Menu/Widgets/item_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ItemsView extends StatelessWidget {
  const ItemsView({super.key, required this.categoryName});

  final String categoryName;

  // Convert First to stateful widget
  // final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return BlocListener<ItemCubit, ItemStates>(
      listener: _listener,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(categoryName),
              centerTitle: true,
              floating: true,
              snap: true,
            ),

            const SliverSizedBox(height: 16),

            SliverPadding(
              padding: .symmetric(horizontal: 16),
              sliver: SliverMainAxisGroup(
                slivers: [
                  // SliverToBoxAdapter(child: _searchField()),

                  // const SliverSizedBox(height: 24),
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Text(
                          l10n.categoryItems,
                          style: AppText().semiBold18(context),
                        ),

                        const Spacer(),

                        BlocWidget<ItemCubit, ItemStates>(
                          buildWhen: (prev, curr) =>
                              curr is! ItemAdded ||
                              curr is! ItemUpdated ||
                              curr is! ItemDeleted,

                          builder: (context, state) {
                            int count = state is ItemsLoaded
                                ? state.data.length
                                : 0;

                            return Skeletonizer(
                              enabled: state is ItemsLoading,
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
                      l10n.itemInstructions,
                      style: AppText().caption(context),
                    ),
                  ),

                  const SliverSizedBox(height: 16),

                  BlocWidget<ItemCubit, ItemStates>(
                    isSliver: true,
                    buildWhen: (prev, curr) =>
                        curr is! ItemAdded ||
                        curr is! ItemUpdated ||
                        curr is! ItemDeleted,

                    builder: (context, state) {
                      if (state is ItemsEmpty) {
                        return SliverFillRemaining(
                          hasScrollBody: false,
                          child: EmptyStateWidget(
                            title: l10n.noItems,
                            message: l10n.noItemsInCategory,
                          ),
                        );
                      } else if (state is ItemsError) {
                        return SliverFillRemaining(
                          hasScrollBody: false,
                          child: EmptyStateWidget(
                            title: l10n.error,
                            message: state.errorMessage,
                            image: Assets.imagesError,
                          ),
                        );
                      } else {
                        var data = state is ItemsLoading
                            ? List.generate(
                                4,
                                (index) => EmptyItemModel(),
                              )
                            : (state as ItemsLoaded).data;

                        return SliverMainAxisGroup(
                          slivers: [
                            Skeletonizer.sliver(
                              enabled: state is ItemsLoading,
                              child: SliverList.separated(
                                itemCount: data.length,
                                separatorBuilder: (_, _) =>
                                    const SizedBox(height: 16),
                                itemBuilder: (_, index) =>
                                    ItemCard(item: data[index]),
                              ),
                            ),

                            const SliverSizedBox(height: 32),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: addItemButton(context),
      ),
    );
  }

  void _listener(BuildContext context, ItemStates state) {
    if (state is ItemAdded) {
      Toast().showSuccess(
        title: AppLocalization.of(context).itemAdded,
        description: AppLocalization.of(context).itemAddedDescription,
      );
    } else if (state is ItemUpdated) {
      Toast().showSuccess(
        title: AppLocalization.of(context).itemUpdated,
        description: AppLocalization.of(context).itemUpdatedDescription,
      );
    } else if (state is ItemDeleted) {
      Toast().showSuccess(
        title: AppLocalization.of(context).itemDeleted,
        description: AppLocalization.of(context).itemDeletedDescription,
      );
    } else if (state is ItemsError) {
      Toast().showError(
        title: AppLocalization.of(context).error,
        description: state.errorMessage,
      );
    }
  }

  Widget addItemButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigation().push(
        context,
        BlocProvider.value(
          value: context.read<ItemCubit>(),
          child: AddItemView(),
        ),
      ),
      backgroundColor: AppConstants().neonBlue,
      shape: const CircleBorder(),
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
