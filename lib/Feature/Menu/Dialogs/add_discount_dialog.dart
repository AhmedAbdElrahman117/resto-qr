import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Cubit/app_cubit.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Widgets/custom_dialog.dart';
import 'package:resto_qr/Core/Widgets/custom_text_field.dart';
import 'package:resto_qr/Core/Widgets/full_width_button.dart';

class AddDiscountDialog extends StatefulWidget {
  const AddDiscountDialog({
    super.key,
    required this.currentPrice,
    this.currentDiscount,
    this.currentExpiry,
  });

  final String currentPrice;
  final String? currentDiscount;
  final DateTime? currentExpiry;

  @override
  State<AddDiscountDialog> createState() => _AddDiscountDialogState();
}

class _AddDiscountDialogState extends State<AddDiscountDialog> {
  late final TextEditingController _discountController;

  late final ValueNotifier<DateTime?> _selectedDateTime;

  late final ValueNotifier<String> _discountPercentage;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _discountController = .new(text: widget.currentDiscount ?? '');
    _selectedDateTime = .new(widget.currentExpiry);
    _discountPercentage = .new(
      calculateDiscountPercentage(
        originalPrice: double.parse(widget.currentPrice),
        discountedPrice: double.parse(
          _discountController.text.isEmpty
              ? widget.currentPrice
              : _discountController.text,
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return CustomDialog(
      child: Form(
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  widget.currentDiscount == null
                      ? l10n.applyDiscount
                      : l10n.updateDiscount,
                  style: AppText().semiBold16(context).copyWith(fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigation().pop(context),
                  padding: .zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              '${l10n.currentPrice(
                AppLocalization.formatNumber(
                  num.parse(widget.currentPrice),
                  context: context,
                ),
              )} \$',
              style: AppText()
                  .semiBold14(context)
                  .copyWith(
                    color: AppConstants().neonBlue,
                  ),
            ),

            const SizedBox(height: 8),

            ValueListenableBuilder(
              valueListenable: _discountPercentage,
              builder: (context, value, child) {
                return Text(
                  l10n.discountPercentage(
                    AppLocalization.formatNumber(
                      num.parse(value),
                      context: context,
                    ),
                  ),
                  style: AppText()
                      .semiBold14(context)
                      .copyWith(
                        color: AppConstants().neonBlue,
                      ),
                );
              },
            ),

            const SizedBox(height: 24),

            CustomTextField(
              controller: _discountController,
              labelText: l10n.discountedPrice,
              hintText: l10n.discountedPriceHint,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),

              prefixIcon: Icons.attach_money,
              onChanged: (value) {
                String discountedPrice = value.isEmpty
                    ? widget.currentPrice
                    : value;

                _discountPercentage.value = calculateDiscountPercentage(
                  originalPrice: double.parse(widget.currentPrice),
                  discountedPrice: double.parse(discountedPrice),
                );
              },
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.enterDiscountedPrice;
                } else if (widget.currentDiscount != null) {
                  int newValue = int.parse(value.trim());
                  int currentValue = int.parse(widget.currentDiscount!);

                  if (newValue == currentValue) {
                    return l10n.differentPrice;
                  }
                } else if (int.parse(value.trim()) >=
                    int.parse(widget.currentPrice)) {
                  return l10n.discountLessThanOriginal;
                }
                return null;
              },
            ),

            const SizedBox(height: 24),

            Text(
              l10n.expirationDateOptional,
              style: AppText()
                  .caption(context)
                  .copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),

            const SizedBox(height: 12),

            ValueListenableBuilder<DateTime?>(
              valueListenable: _selectedDateTime,
              builder: (context, selectedDateTime, _) {
                return InkWell(
                  onTap: _pickDateTime,
                  borderRadius: .circular(12),
                  child: Container(
                    padding: const .symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: .all(color: AppTheme().borderColor(context)),
                      borderRadius: .circular(12),
                      color: AppTheme().primaryBackground(context),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: selectedDateTime != null
                              ? AppConstants().neonBlue
                              : AppTheme().secondaryText(context),
                          size: 20,
                        ),

                        const SizedBox(width: 12),

                        Text(
                          selectedDateTime != null
                              ? AppLocalization.formatDateTime(
                                  selectedDateTime,
                                  context: context,
                                )
                              : l10n.SelectDateAndTime,
                          style: AppText()
                              .regular14(context)
                              .copyWith(
                                color: selectedDateTime != null
                                    ? AppTheme().primaryText(context)
                                    : AppTheme().secondaryText(context),
                              ),
                        ),
                        const Spacer(),
                        if (selectedDateTime != null)
                          InkWell(
                            onTap: () => _selectedDateTime.value = null,
                            child: Icon(
                              Icons.clear,
                              size: 20,
                              color: AppTheme().secondaryText(context),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 32),

            Row(
              children: [
                Expanded(
                  child: cancelButton(context),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: saveButton(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String calculateDiscountPercentage({
    required double originalPrice,
    required double discountedPrice,
  }) {
    double difference = originalPrice - discountedPrice;
    double percentage = (difference / originalPrice) * 100;

    // 1. Round to exactly 1 decimal place (e.g., 20.53 -> "20.5", 20.00 -> "20.0")
    String formattedPercentage = percentage.toStringAsFixed(1);

    // 2. Remove the trailing ".0" if it exists so it has a MAX of 1 decimal
    if (formattedPercentage.endsWith('.0')) {
      formattedPercentage = formattedPercentage.substring(
        0,
        formattedPercentage.length - 2,
      );
    }

    return formattedPercentage;
  }

  Future<void> _pickDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      locale: Locale(context.read<AppCubit>().state.languageCode),
      initialDate:
          _selectedDateTime.value ??
          DateTime.now().add(const Duration(days: 1)),
      firstDate: _selectedDateTime.value ?? DateTime.now(),
      lastDate:
          _selectedDateTime.value?.add(const Duration(days: 365 * 100)) ??
          DateTime.now().add(const Duration(days: 365 * 100)),
      builder: (context, child) {
        return child!;
      },
    );

    if (pickedDate != null) {
      if (!mounted) return;
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedDateTime.value != null
            ? TimeOfDay.fromDateTime(_selectedDateTime.value!)
            : TimeOfDay.now(),
        builder: (context, child) {
          return child!;
        },
      );

      if (pickedTime != null) {
        _selectedDateTime.value = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }
  }

  FullWidthButton saveButton(BuildContext context) {
    return FullWidthButton(
      labelText: AppLocalization.of(context).save,
      backgroundColor: AppConstants().neonBlue,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Navigation().pop(context, {
            'discount': _discountController.text,
            'expiresAt': _selectedDateTime.value,
            'discountPercentage': _discountPercentage.value,
          });
        }
      },
    );
  }

  TextButton cancelButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigation().pop(context),
      style: TextButton.styleFrom(
        padding: const .symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: .circular(8),
        ),
      ),
      child: Text(
        AppLocalization.of(context).cancel,
        style: AppText()
            .semiBold14(context)
            .copyWith(
              color: AppTheme().secondaryText(context),
            ),
      ),
    );
  }

  @override
  void dispose() {
    _discountController.dispose();
    _selectedDateTime.dispose();
    super.dispose();
  }
}
