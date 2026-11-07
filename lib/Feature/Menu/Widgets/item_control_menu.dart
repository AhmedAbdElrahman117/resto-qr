import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Dialogs/general_dialog.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_dialogs.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Widgets/custom_dialog.dart';
import 'package:resto_qr/Core/Widgets/custom_switch_tile.dart';
import 'package:resto_qr/Feature/Menu/Dialogs/add_discount_dialog.dart';
import 'package:resto_qr/Feature/Menu/Models/item_model.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Item%20Cubit/item_cubit.dart';
import 'package:resto_qr/Feature/Menu/Views/add_item_view.dart';

// TODO: needs to be refined with the cubit
class ItemControlMenu extends StatefulWidget {
  const ItemControlMenu({
    super.key,
    required this.item,
  });

  final ItemModel item;

  @override
  State<ItemControlMenu> createState() => _ItemControlMenuState();
}

class _ItemControlMenuState extends State<ItemControlMenu> {
  late final ValueNotifier<bool?> isVisible;
  final ValueNotifier<String?> loadingAction = ValueNotifier(null);

  @override
  void initState() {
    isVisible = ValueNotifier(widget.item.isVisible);
    super.initState();
  }

  @override
  void dispose() {
    isVisible.dispose();
    loadingAction.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    final cubit = context.read<ItemCubit>();

    return CustomDialog(
      padding: .zero,
      child: ValueListenableBuilder<String?>(
        valueListenable: loadingAction,
        builder: (context, currentAction, child) {
          return Column(
            mainAxisSize: .min,
            children: [
              header(context),

              const Divider(height: 1),

              ValueListenableBuilder<bool?>(
                valueListenable: isVisible,
                builder: (context, value, child) {
                  final bool isLoading = value == null;
                  final bool currentSwitchState =
                      value ?? widget.item.isVisible;

                  return CustomSwitchTile(
                    initialValue: currentSwitchState,
                    title: l10n.itemVisibleToCustomers,
                    color: AppConstants().neonBlue,
                    secondry: isLoading
                        ? CircularProgressIndicator.adaptive(
                            backgroundColor: AppConstants().neonBlue,
                          )
                        : const Icon(Icons.visibility_outlined),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    radius: 0,
                    onToggle: isLoading
                        ? null
                        : (newValue) async {
                            try {
                              isVisible.value = null;

                              await cubit.toggleAvailability(
                                item: widget.item,
                                isVisible: newValue,
                              );

                              isVisible.value = newValue;
                            } catch (e) {
                              isVisible.value = widget.item.isVisible;
                            }
                          },
                  );
                },
              ),

              const Divider(height: 1),

              optionTile(
                context: context,
                icon: Icons.discount,
                title: widget.item.discount == null
                    ? l10n.applyDiscount
                    : l10n.updateDiscount,
                isLoading: currentAction == 'update_discount',
                onTap: () async {
                  var res = await AppDialogs().showDialog(
                    context: context,
                    child: AddDiscountDialog(
                      currentPrice: widget.item.price,
                      currentDiscount: widget.item.discount,
                      currentExpiry: widget.item.expiresAt,
                    ),
                  );

                  if (res != null) {
                    loadingAction.value = 'update_discount';
                    await cubit.updateItem(
                      item: widget.item.copyWith(
                        discount: () => res['discount'].toString(),
                        expiresAt: () => res['expiresAt'],
                        discountPercent: () => res['discountPercentage'],
                      ),
                    );
                    loadingAction.value = null;
                    if (!context.mounted) return;
                    Navigation().pop(context);
                  }
                },
              ),

              if (widget.item.discount != null) ...[
                const Divider(height: 1),

                optionTile(
                  context: context,
                  icon: Icons.remove,
                  title: l10n.removeDiscountTitle,
                  isLoading: currentAction == 'remove_discount',
                  onTap: () async {
                    AppDialogs().showDialog(
                      context: context,
                      child: GeneralDialog(
                        title: l10n.removeDiscountTitle,
                        message:
                            'Are you sure you want to remove the discount from this item?',
                        onConfirm: (dialogContext) async {
                          Navigation().pop(dialogContext);

                          loadingAction.value = 'remove_discount';
                          await cubit.updateItem(
                            item: widget.item.copyWith(
                              discount: () => null,
                              expiresAt: () => null,
                            ),
                          );
                          loadingAction.value = null;
                          if (!context.mounted) return;
                          Navigation().pop(context);
                        },
                      ),
                    );
                  },
                ),
              ],

              const Divider(height: 1),

              optionTile(
                context: context,
                icon: Icons.edit_outlined,
                title: l10n.editItemDetails,
                onTap: () {
                  Navigation().push(
                    context,
                    BlocProvider.value(
                      value: context.read<ItemCubit>(),
                      child: AddItemView(currentItem: widget.item),
                    ),
                  );
                },
              ),

              const Divider(height: 1),

              optionTile(
                context: context,
                icon: Icons.delete_outline,
                title: l10n.deleteItem,
                color: AppConstants().errorRed,
                isLoading: currentAction == 'delete_item',
                borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(12),
                  bottomStart: Radius.circular(12),
                ),
                onTap: () {
                  AppDialogs().showDialog(
                    context: context,
                    child: GeneralDialog(
                      onConfirm: (dialogContext) async {
                        Navigation().pop(dialogContext); // pop dialog first

                        loadingAction.value = 'delete_item';
                        await cubit.deleteItem(item: widget.item);
                        loadingAction.value = null;
                        if (!context.mounted) return;
                        Navigation().pop(context);
                      },
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget optionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    Color? color,
    BorderRadiusGeometry? borderRadius,
    void Function()? onTap,
    bool isLoading = false,
  }) {
    return ListTile(
      contentPadding: const .symmetric(horizontal: 24, vertical: 8),
      leading: isLoading
          ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 2.5,
                backgroundColor: color ?? AppConstants().neonBlue,
              ),
            )
          : Icon(icon, color: color),
      title: Text(
        title,
        style: AppText().bold16(context).copyWith(color: color),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.zero,
      ),
      onTap: isLoading ? null : onTap,
    );
  }

  Widget header(BuildContext context) {
    return Padding(
      padding: const .fromLTRB(24, 20, 16, 16),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(
            AppLocalization.of(context).manageItem,
            style: AppText().semiBold20(context),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
