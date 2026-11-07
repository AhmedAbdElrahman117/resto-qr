import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Widgets/custom_dialog.dart';
import 'package:resto_qr/Core/Widgets/custom_text_field.dart';

class AddIngredientsDialog extends StatefulWidget {
  const AddIngredientsDialog({super.key, this.initialIngredients});

  final List<String>? initialIngredients;

  @override
  State<AddIngredientsDialog> createState() => _AddIngredientsDialogState();
}

class _AddIngredientsDialogState extends State<AddIngredientsDialog> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final ScrollController _scrollController = ScrollController();

  late final List<String> ingredients;

  late final ValueNotifier<int> ingredientLength;

  @override
  void initState() {
    ingredients = widget.initialIngredients ?? [''];
    ingredientLength = ValueNotifier(widget.initialIngredients?.length ?? 1);
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

          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              l10n.ingredientsTip,
              style: AppText().smallTag(context),
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: ValueListenableBuilder(
              valueListenable: ingredientLength,
              builder: (context, value, child) {
                return AnimatedList.separated(
                  key: _listKey,
                  controller: _scrollController,
                  initialItemCount: ingredients.length,
                  removedSeparatorBuilder: (context, index, animation) {
                    return const SizedBox(height: 20);
                  },
                  separatorBuilder: (context, index, animation) {
                    return const SizedBox(height: 20);
                  },
                  itemBuilder: (context, index, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(-1, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(
                        opacity: animation,
                        child: ingredientItem(
                          context: context,
                          index: index,
                          onPressed: () {
                            if (ingredientLength.value > 1) {
                              _listKey.currentState?.removeItem(
                                index,
                                (context, animation) => SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(-1, 0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: FadeTransition(
                                    opacity: animation,
                                    child: ingredientItem(
                                      context: context,
                                      index: index,
                                      onPressed: null,
                                    ),
                                  ),
                                ),
                              );
                              ingredientLength.value--;
                              ingredients.removeAt(index);
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          addItemButton(context),

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

  OutlinedButton cancelButton(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        Navigation().pop(context, widget.initialIngredients);
      },
      style: OutlinedButton.styleFrom(
        padding: .symmetric(horizontal: 20, vertical: 12),
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
                  AppLocalization.of(context).addIngredients,
                  style: AppText().bold24(context),
                ),

                const SizedBox(height: 4),

                Text(
                  AppLocalization.of(context).ingredientPerLine,
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
      valueListenable: ingredientLength,
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
            AppLocalization.of(context).ingredientCount(value),
            style: AppText().semiBold14(context, AppConstants().neonBlue),
          ),
        );
      },
    );
  }

  ElevatedButton addItemButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        ingredientLength.value++;
        ingredients.add('');
        _listKey.currentState?.insertItem(ingredientLength.value - 1);
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 80,
          duration: Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      },
      icon: Icon(Icons.add, color: AppTheme().primaryText(context)),
      label: Text(
        AppLocalization.of(context).addIngredient,
        style: AppText().regular16(context),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppConstants().neonBlue,
        padding: .symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  ElevatedButton saveButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        var res = ingredients
            .where((element) => element.trim().isNotEmpty)
            .toList();

        Navigation().pop(
          context,
          res.isEmpty ? null : res,
        );
      },

      icon: Icon(Icons.check, color: AppTheme().primaryText(context)),

      label: Text(
        AppLocalization.of(context).save,
        style: AppText().regular16(context),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppConstants().successColor,
        padding: .symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: .circular(16),
        ),
      ),
    );
  }

  Widget ingredientItem({
    required BuildContext context,
    required int index,
    void Function()? onPressed,
  }) {
    return Row(
      spacing: 12,
      children: [
        Expanded(
          child: CustomTextField(
            controller: widget.initialIngredients != null
                ? .new(text: ingredients[index])
                : null,
            labelText: AppLocalization.of(context).ingredientLabel(index + 1),
            hintText: AppLocalization.of(context).ingredientHint,
            onChanged: (value) => ingredients[index] = value,
          ),
        ),

        IconButton.filled(
          onPressed: onPressed,
          icon: Icon(Icons.close, color: Colors.white),
          style: IconButton.styleFrom(
            backgroundColor: Colors.red,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    ingredientLength.dispose();
    super.dispose();
  }
}
