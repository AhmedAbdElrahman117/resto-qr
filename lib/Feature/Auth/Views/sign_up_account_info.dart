import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Widgets/custom_text_field.dart';
import 'package:resto_qr/Feature/Auth/Helper/account_info_helper.dart';
import 'package:resto_qr/Feature/Auth/Widgets/confirm_password_text_field.dart';
import 'package:resto_qr/Feature/Auth/Widgets/email_text_field.dart';
import 'package:resto_qr/Feature/Auth/Widgets/password_constraint_card.dart';
import 'package:resto_qr/Feature/Auth/Widgets/password_text_field.dart';
import 'package:resto_qr/Feature/Auth/Widgets/phone_text_field.dart';

class SignUpAccountInfo extends StatelessWidget {
  const SignUpAccountInfo({
    super.key,
    required this.accountInfoHelper,
  });

  final AccountInfoHelper accountInfoHelper;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    accountInfoHelper.constraintController.setTitles([
      l10n.atLeastEightCharacters,
      l10n.atLeastOneNumber,
      l10n.atLeastOneSpecialCharacter,
    ]);
    return Form(
      key: accountInfoHelper.accountInfo,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.accountInfo,
              style: AppText().bold24(context),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.createLoginCredentials,
              style: AppText().regular14(context),
            ),
            const SizedBox(height: 36),

            userNameField(context),
            const SizedBox(height: 12),
            EmailTextField(
              controller: accountInfoHelper.emailController,
              focusNode: accountInfoHelper.emailFocus,
              nextFocus: accountInfoHelper.phoneFocus,
            ),
            const SizedBox(height: 12),
            PhoneTextField(
              controller: accountInfoHelper.phoneController,
              focusNode: accountInfoHelper.phoneFocus,
              nextFocus: accountInfoHelper.passwordFocus,
            ),
            const SizedBox(height: 12),
            PasswordTextField(
              controller: accountInfoHelper.passwordController,
              focusNode: accountInfoHelper.passwordFocus,
              nextFocus: accountInfoHelper.confirmPasswordFocus,
              onChanged: (value) {
                accountInfoHelper.constraintController.checkPassword();
                accountInfoHelper.constraintController.allValid();
              },
            ),
            const SizedBox(height: 12),
            ConfirmPasswordTextField(
              controller: accountInfoHelper.confirmPasswordController,
              passwordController: accountInfoHelper.passwordController,
              focusNode: accountInfoHelper.confirmPasswordFocus,
            ),
            const SizedBox(height: 16),
            passwordConstraints(),
          ],
        ),
      ),
    );
  }

  CustomTextField userNameField(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return CustomTextField(
      controller: accountInfoHelper.nameController,
      focusNode: accountInfoHelper.nameFocus,
      nextFocus: accountInfoHelper.emailFocus,
      labelText: l10n.userName,
      hintText: l10n.enterYourFullName,
      prefixIcon: Icons.person_rounded,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return l10n.pleaseEnterYourName;
        }
        return null;
      },
    );
  }

  Widget passwordConstraints() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: .start,
        spacing: 16,
        children: accountInfoHelper.constraintController.constraints!
            .map(
              (e) => ValueListenableBuilder(
                valueListenable: e.value,
                builder: (context, value, child) {
                  return PasswordConstraintCard(
                    constraint: value,
                    text: e.title,
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
