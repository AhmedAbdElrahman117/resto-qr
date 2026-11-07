import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Utils/assets.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Widgets/bloc_widget.dart';
import 'package:resto_qr/Core/Widgets/custom_dialog.dart';
import 'package:resto_qr/Core/Widgets/empty_state_widget.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Login%20Cubit/login_cubit.dart';
import 'package:resto_qr/Feature/Menu/Models/item_model.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Offer%20Cubit/offer_cubit.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Offer%20Cubit/offer_states.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddOfferItemDialog extends StatefulWidget {
  const AddOfferItemDialog({super.key, this.initialItems});

  final List<ItemModel>? initialItems;

  @override
  State<AddOfferItemDialog> createState() => _AddOfferItemDialogState();
}

class _AddOfferItemDialogState extends State<AddOfferItemDialog> {
  late final ValueNotifier<List<ItemModel>> selectedItems;

  @override
  void initState() {
    selectedItems = ValueNotifier(List.from(widget.initialItems ?? []));
    context.read<OfferCubit>().getAllItems(
      restaurantId: context.read<LoginCubit>().state.user.restaurantID!,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return CustomDialog(
      child: Column(
        mainAxisSize: .min,
        children: [
          const SizedBox(height: 12),

          _header(context),

          const SizedBox(height: 20),

          Expanded(
            child: BlocWidget<OfferCubit, OfferStates>(
              buildWhen: (prev, curr) =>
                  curr is OfferItemsLoading ||
                  curr is OfferItemsLoaded ||
                  curr is OfferItemsEmpty ||
                  curr is OfferItemsError,
              builder: (context, state) {
                if (state is OfferItemsError) {
                  return EmptyStateWidget(
                    title: l10n.error,
                    message: state.message,
                    image: Assets.imagesError,
                  );
                } else if (state is OfferItemsEmpty) {
                  return EmptyStateWidget(
                    title: l10n.noItems,
                    message: l10n.noItemsAvailable,
                  );
                }

                var data = (state is OfferItemsLoaded
                    ? state.items
                    : List.generate(5, (index) => EmptyItemModel()));

                return Skeletonizer(
                  enabled: state is OfferItemsLoading,
                  enableSwitchAnimation: true,
                  child: ListView.separated(
                    itemCount: data.length,
                    separatorBuilder: (context, index) => SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      return OfferItem(
                        item: data[index],
                        selectedItems: selectedItems,
                      );
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(child: cancelButton(context)),
              const SizedBox(width: 12),
              Expanded(child: saveButton(context)),
            ],
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      padding: const .all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppConstants().neonBlue.withValues(alpha: 0.18),
            AppConstants().successColor.withValues(alpha: 0.12),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: .circular(18),
      ),
      child: Row(
        children: [
          Container(
            padding: const .all(12),
            decoration: BoxDecoration(
              color: AppConstants().neonBlue,
              shape: .circle,
            ),
            child: const Icon(Icons.playlist_add, color: Colors.white),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  AppLocalization.of(context).addItems,
                  style: AppText().bold24(context),
                ),

                const SizedBox(height: 4),

                Text(
                  AppLocalization.of(context).selectOfferItems,
                  style: AppText().regular14(context),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          _countChip(context),
        ],
      ),
    );
  }

  Widget _countChip(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedItems,
      builder: (context, value, child) {
        return Container(
          padding: const .symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppConstants().neonBlue.withValues(alpha: 0.12),
            borderRadius: .circular(999),
            border: Border.all(
              color: AppConstants().neonBlue.withValues(alpha: 0.35),
            ),
          ),
          child: Text(
            AppLocalization.of(context).ingredientCount(value.length),
            style: AppText().semiBold14(context, AppConstants().neonBlue),
          ),
        );
      },
    );
  }

  OutlinedButton cancelButton(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        Navigation().pop(context, widget.initialItems);
      },
      style: OutlinedButton.styleFrom(
        padding: const .symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: .circular(16),
        ),
      ),
      icon: Icon(
        Icons.close,
        color: AppTheme().primaryText(context),
      ),
      label: Text(
        AppLocalization.of(context).cancel,
        style: AppText().regular16(context),
      ),
    );
  }

  ElevatedButton saveButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigation().pop(context, selectedItems.value);
      },

      icon: Icon(Icons.check, color: AppTheme().primaryText(context)),

      label: Text(
        AppLocalization.of(context).save,
        style: AppText().regular16(context),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppConstants().successColor,
        padding: const .symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: .circular(16),
        ),
      ),
    );
  }
}

class OfferItem extends StatelessWidget {
  const OfferItem({super.key, required this.item, required this.selectedItems});

  final ItemModel item;
  final ValueNotifier<List<ItemModel>> selectedItems;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedItems,
      builder: (context, value, child) {
        return CheckboxListTile(
          value: value.any((element) => element.id == item.id),
          title: Text(
            item.name,
            style: AppText().regular16(context),
          ),
          secondary: Icon(
            Icons.fastfood,
            color: AppTheme().primaryText(context),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: .circular(12),
          ),
          activeColor: AppConstants().neonBlue,
          onChanged: (state) {
            if (state == true) {
              selectedItems.value = [...selectedItems.value, item];
            } else {
              selectedItems.value = selectedItems.value
                  .where((element) => element.id != item.id)
                  .toList();
            }
          },
        );
      },
    );
  }
}
