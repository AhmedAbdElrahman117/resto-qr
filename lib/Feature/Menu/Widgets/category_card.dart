import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resto_qr/Core/Dialogs/general_dialog.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_dialogs.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Widgets/universal_image.dart';
import 'package:resto_qr/Feature/Menu/Models/category_model.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Category%20Cubit/category_cubit.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Category%20Cubit/category_state.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Item%20Cubit/item_cubit.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Offer%20Cubit/offer_cubit.dart';
import 'package:resto_qr/Feature/Menu/Views/add_category_view.dart';
import 'package:resto_qr/Feature/Menu/Views/items_view.dart';
import 'package:resto_qr/Feature/Menu/Views/offers_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    this.showControls,
    this.showNumberOfItems,
    this.showStatus,
  });

  final CategoryModel category;
  final bool? showControls;
  final bool? showStatus;
  final bool? showNumberOfItems;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      buildWhen: (previous, current) =>
          current is CategoryDeleteLoading || current is CategoryDeleted,
      builder: (context, state) {
        var isLoading =
            state is CategoryDeleteLoading && category.id == state.categoryID;

        return Skeletonizer(
          enabled: isLoading,
          child: Material(
            color: AppTheme().fillColor(context),
            shape: RoundedRectangleBorder(
              borderRadius: .circular(12),
              side: BorderSide(
                color: AppTheme().borderColor(context),
                width: 2,
              ),
            ),
            child: InkWell(
              borderRadius: .circular(12),
              onTap: () => category.id != 'offers'
                  ? Navigation().push(
                      context,
                      BlocProvider(
                        create: (context) =>
                            ItemCubit(categoryID: category.id!),
                        child: ItemsView(categoryName: category.name),
                      ),
                    )
                  : Navigation().push(
                      context,
                      BlocProvider(
                        create: (context) =>
                            OfferCubit(menuID: category.menuID!),
                        child: OffersView(),
                      ),
                    ),
              child: Padding(
                padding: const .all(16),
                child: Column(
                  children: [
                    _itemDetails(context),

                    Visibility(
                      visible: showControls ?? true,
                      child: Column(
                        children: [
                          Divider(
                            color: AppTheme().borderColor(context),
                            height: 28,
                          ),

                          _itemControls(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _itemDetails(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          padding: const .all(12),
          decoration: BoxDecoration(
            color: AppConstants().neonBlue.withValues(alpha: 0.12),
            borderRadius: .circular(12),
          ),
          child: UniversalImage(source: category.imageURL ?? 'http'),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            spacing: 4,
            crossAxisAlignment: .start,
            children: [
              Text(
                category.name,
                style: AppText().semiBold16(context),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              Visibility(
                visible: showNumberOfItems ?? true,
                child: Text(
                  AppLocalization.of(context).itemsCount(category.itemsCount),
                  style: AppText().caption(context),
                ),
              ),
            ],
          ),
        ),

        Visibility(
          visible: showStatus ?? true,
          child: BlocBuilder<CategoryCubit, CategoryState>(
            buildWhen: (previous, current) =>
                current is CategoryToggled || current is CategoryToggleLoading,
            builder: (context, state) {
              var isLoading = state is CategoryToggleLoading;

              var value = isLoading
                  ? null
                  : (state is CategoryToggled
                        ? state.isLive
                        : category.isVisible);

              final color = value == null
                  ? Colors.grey
                  : value
                  ? AppConstants().successColor
                  : AppConstants().errorRed;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const .symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: .circular(20),
                ),
                child: Text(
                  value == null
                      ? AppLocalization.of(context).updating
                      : (value
                            ? AppLocalization.of(context).live
                            : AppLocalization.of(context).hidden),
                  style: AppText().semiBold14(context, color),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _itemControls(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Expanded(child: _editButton(context)),
        _hideButton(context),
        _deleteButton(context),
      ],
    );
  }

  Widget _editButton(BuildContext context) {
    return TextButton.icon(
      onPressed: () => Navigation().push(
        context,
        BlocProvider.value(
          value: context.read<CategoryCubit>(),
          child: AddCategoryView(currentCategory: category),
        ),
      ),
      icon: const Icon(Icons.edit, size: 16),
      label: Text(
        AppLocalization.of(context).edit,
        style: AppText().semiBold14(context, Colors.white),
      ),
      style: TextButton.styleFrom(
        backgroundColor: AppConstants().neonBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: .circular(12),
        ),
        padding: const .symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }

  Widget _hideButton(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      buildWhen: (previous, current) =>
          current is CategoryToggled || current is CategoryToggleLoading,
      builder: (context, state) {
        var isLoading = state is CategoryToggleLoading;

        var value = isLoading
            ? null
            : (state is CategoryToggled ? state.isLive : category.isVisible);

        return IconButton(
          onPressed: value == null
              ? null
              : () async {
                  await context
                      .read<CategoryCubit>()
                      .toggleCategoryAvailability(
                        category: category,
                        isVisible: !(value),
                      );
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
                ? const FaIcon(FontAwesomeIcons.eye, key: ValueKey('eye'))
                : const FaIcon(
                    FontAwesomeIcons.eyeSlash,
                    key: ValueKey('slash'),
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
              borderRadius: .circular(12),
            ),
            padding: const .symmetric(vertical: 12, horizontal: 16),
          ),
        );
      },
    );
  }

  Widget _deleteButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        AppDialogs().showDialog(
          context: context,
          child: GeneralDialog(
            onConfirm: (dialogContext) {
              Navigation().pop(dialogContext);
              context.read<CategoryCubit>().deleteCategory(
                category: category,
              );
            },
          ),
        );
      },
      icon: const Icon(Icons.delete_outline_rounded),
      style: IconButton.styleFrom(
        backgroundColor: AppConstants().errorRed.withValues(alpha: 0.12),
        foregroundColor: AppConstants().errorRed,
        shape: RoundedRectangleBorder(borderRadius: .circular(12)),
        padding: const .symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }
}
