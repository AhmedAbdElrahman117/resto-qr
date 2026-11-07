import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/country_picker_dialog.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_intl_phone_field/phone_number.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({
    super.key,
    required this.controller,
    this.focusNode,
    this.nextFocus,
    this.onFieldSubmitted,
    this.onChanged,
  });

  final TextEditingController controller;

  final FocusNode? focusNode;
  final FocusNode? nextFocus;

  // if you finished the form and want to perform an action
  final void Function()? onFieldSubmitted;
  final void Function(PhoneNumber number)? onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return IntlPhoneField(
      controller: controller,
      dialogType: DialogType.showModalBottomSheet,
      buildCounter:
          (
            context, {
            required currentLength,
            required isFocused,
            required maxLength,
          }) => null,
      pickerDialogStyle: dialogDecoration(context),
      initialCountryCode: 'EG',
      dropdownTextStyle: AppText().regular14(context),
      focusNode: focusNode,
      decoration: fieldDecoration(context),
      style: AppText().regular16(context),
      onSubmitted: (value) {
        if (nextFocus != null && focusNode != null) {
          focusNode!.unfocus();
          nextFocus!.requestFocus();
        }
        if (onFieldSubmitted != null) {
          onFieldSubmitted!.call();
        }
      },
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.number.trim().isEmpty) {
          return l10n.phoneRequired;
        } else if (!value.isValidNumber()) {
          return l10n.invalidNumber;
        }
        return null;
      },
    );
  }

  PickerDialogStyle dialogDecoration(BuildContext context) {
    return PickerDialogStyle(
      padding: .all(16),
      searchFieldPadding: .only(top: 20, left: 16, right: 16),
      searchFieldCursorColor: AppConstants().neonBlue,
      backgroundColor: AppTheme().primaryBackground(context),
      countryCodeStyle: AppText().caption(context),
      countryNameStyle: AppText().bold14(context),
      searchFieldInputDecoration: searchCountryDecoration(context),
    );
  }

  InputDecoration fieldDecoration(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return InputDecoration(
      filled: true,
      fillColor: AppTheme().fillColor(context),
      border: OutlineInputBorder(
        borderRadius: .circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: .circular(8),
        borderSide: BorderSide(color: AppConstants().errorRed),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: .circular(8),
      ),
      labelText: l10n.phoneNumber,
      prefixIcon: Icon(Icons.phone),
      prefixIconColor: Color(0xFF64748B),
      hintText: l10n.enterYourPhoneNumber,
      hintStyle: AppText().caption(context).copyWith(fontSize: 16),
      labelStyle: AppText().caption(context).copyWith(fontSize: 16),
    );
  }

  InputDecoration searchCountryDecoration(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return InputDecoration(
      filled: true,
      fillColor: AppTheme().fillColor(context),
      border: OutlineInputBorder(
        borderRadius: .circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: .circular(8),
        borderSide: BorderSide(color: AppConstants().errorRed),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: .circular(8),
      ),
      labelText: l10n.searchCountry,
      prefixIcon: Icon(Icons.search),
      prefixIconColor: Color(0xFF64748B),
      hintText: l10n.enterCountryNameOrCode,
      hintStyle: AppText().caption(context).copyWith(fontSize: 16),
      labelStyle: AppText().caption(context).copyWith(fontSize: 16),
    );
  }
}
