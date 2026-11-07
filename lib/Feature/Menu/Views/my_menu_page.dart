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
import 'package:resto_qr/Core/Widgets/empty_state_widget.dart';
import 'package:resto_qr/Core/Widgets/sliver_sized_box.dart';
import 'package:resto_qr/Feature/Menu/Models/category_model.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Category%20Cubit/category_cubit.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Category%20Cubit/category_state.dart';
import 'package:resto_qr/Feature/Menu/Views/add_category_view.dart';
import 'package:resto_qr/Feature/Menu/Widgets/category_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyMenuPage extends StatelessWidget {
  const MyMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return Scaffold(
      body: BlocListener<CategoryCubit, CategoryState>(
        listener: _listener,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(l10n.myMenu),
              centerTitle: true,
              floating: true,
              snap: true,
            ),

            const SliverSizedBox(height: 16),

            SliverPadding(
              padding: .symmetric(horizontal: 16),
              sliver: SliverMainAxisGroup(
                slivers: [
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text(
                          l10n.categories,
                          style: AppText().semiBold18(context),
                        ),

                        BlocWidget<CategoryCubit, CategoryState>(
                          isSliver: true,
                          buildWhen: (prev, curr) =>
                              curr is! CategoryActionLoading &&
                              curr is! CategoryAdded &&
                              curr is! CategoryUpdated &&
                              curr is! CategoryToggleLoading &&
                              curr is! CategoryDeleteLoading &&
                              curr is! CategoryDeleted &&
                              curr is! CategoryToggled,
                          builder: (context, state) {
                            int count = 0;

                            if (state is CategoryLoaded) {
                              count = state.categories.length;
                            }

                            return CounterWidget(count: count + 1);
                          },
                        ),
                      ],
                    ),
                  ),

                  const SliverSizedBox(height: 6),

                  SliverToBoxAdapter(
                    child: Text(
                      l10n.menuCategoriesDescription,
                      style: AppText().caption(context),
                    ),
                  ),

                  const SliverSizedBox(height: 24),

                  BlocWidget<CategoryCubit, CategoryState>(
                    isSliver: true,
                    buildWhen: (prev, curr) =>
                        curr is CategoryError ||
                        curr is CategoryEmpty ||
                        curr is CategoryLoading ||
                        curr is CategoryLoaded,
                    builder: (context, state) {
                      if (state is CategoryError) {
                        return SliverFillRemaining(
                          hasScrollBody: false,
                          child: EmptyStateWidget(
                            title: l10n.error,
                            message: state.errorMessage,
                            image: Assets.imagesError,
                          ),
                        );
                      } else if (state is CategoryEmpty) {
                        return SliverFillRemaining(
                          hasScrollBody: false,
                          child: EmptyStateWidget(
                            title: l10n.noCategoriesYet,
                            message: l10n.addCategoriesDescription,
                          ),
                        );
                      } else {
                        var data = state is CategoryLoading
                            ? List.generate(
                                3,
                                (index) => EmptyCategoryModel(),
                              )
                            : [
                                CategoryModel(
                                  id: 'offers',
                                  name: AppLocalization.of(context).offers,
                                  menuID: context.read<CategoryCubit>().menuID,
                                  isVisible: true,
                                  imageURL: Assets.imagesOffer,
                                  createdAt: DateTime.now(),
                                  itemsCount: 0,
                                ),
                                ...(state as CategoryLoaded).categories,
                              ];

                        return Skeletonizer.sliver(
                          enabled: state is CategoryLoading,
                          child: SliverList.separated(
                            itemCount: data.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 12),
                            itemBuilder: (_, index) => CategoryCard(
                              category: data[index],
                              showControls: index != 0,
                              showNumberOfItems: index != 0,
                              showStatus: index != 0,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),

            const SliverSizedBox(height: 32),
          ],
        ),
      ),
      floatingActionButton: addCategoryButton(context),
    );
  }

  void _listener(BuildContext context, state) {
    if (state is CategoryAdded) {
      Toast().showSuccess(
        title: AppLocalization.of(context).categoryAdded,
        description: AppLocalization.of(context).categoryAddedDescription,
      );
    } else if (state is CategoryUpdated) {
      Toast().showSuccess(
        title: AppLocalization.of(context).categoryUpdated,
        description: AppLocalization.of(context).categoryUpdatedDescription,
      );
    } else if (state is CategoryDeleted) {
      Toast().showSuccess(
        title: AppLocalization.of(context).categoryDeleted,
        description: AppLocalization.of(context).categoryDeletedDescription,
      );
    } else if (state is CategoryToggled) {
      String status = state.isLive ? 'is Live on' : 'is Hidden from';
      Toast().showSuccess(
        title: AppLocalization.of(context).categoryToggled,
        description: 'Category $status menu',
      );
    } else if (state is CategoryError) {
      Toast().showSuccess(
        title: AppLocalization.of(context).categoryFailed,
        description: state.message,
      );
    }
  }

  Widget addCategoryButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigation().push(
        context,
        BlocProvider.value(
          value: context.read<CategoryCubit>(),
          child: AddCategoryView(),
        ),
      ),
      backgroundColor: AppConstants().neonBlue,
      shape: const CircleBorder(),
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
