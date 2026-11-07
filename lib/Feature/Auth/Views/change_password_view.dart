import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Widgets/full_width_button.dart';
import 'package:resto_qr/Core/Widgets/loading_view.dart';
import 'package:resto_qr/Feature/Auth/Helper/constraint_controller.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Forgot%20Password%20Cubit/forgot_password_cubit.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Forgot%20Password%20Cubit/forgot_password_state.dart';
import 'package:resto_qr/Feature/Auth/Widgets/confirm_password_text_field.dart';
import 'package:resto_qr/Feature/Auth/Widgets/password_constraint_card.dart';
import 'package:resto_qr/Feature/Auth/Widgets/password_text_field.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({
    super.key,
    required this.cubit,
    required this.email,
  });

  final String email;
  final ForgotPasswordCubit cubit;

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final GlobalKey<FormState> _formKey = .new();

  final TextEditingController passwordController = .new();

  final TextEditingController confirmPasswordController = .new();

  final FocusNode passwordFocus = .new();

  final FocusNode confirmPasswordFocus = .new();

  final ValueNotifier<bool> isValid = ValueNotifier(false);

  late final ConstraintController constraintController = .new(
    passwordController: passwordController,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    constraintController.setTitles([
      l10n.atLeastEightCharacters,
      l10n.atLeastOneNumber,
      l10n.atLeastOneSpecialCharacter,
    ]);
    return BlocProvider.value(
      value: widget.cubit,
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(),
            body: Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  padding: .all(20),
                  child: Column(
                    children: [
                      Text(
                        l10n.changePassword,
                        style: AppText().bold28(context),
                        textAlign: .start,
                      ),
                      SizedBox(height: 12),
                      Text(
                        l10n.changePasswordDescription,
                        style: AppText().regular16(context),
                        textAlign: .center,
                      ),
                      SizedBox(height: 36),
                      PasswordTextField(
                        controller: passwordController,
                        focusNode: passwordFocus,
                        nextFocus: confirmPasswordFocus,
                        onChanged: (value) {
                          constraintController.checkPassword();
                          constraintController.allValid();
                        },
                      ),
                      SizedBox(height: 28),
                      ConfirmPasswordTextField(
                        controller: confirmPasswordController,
                        passwordController: passwordController,
                        focusNode: confirmPasswordFocus,
                        onFieldSubmitted: () {
                          change();
                        },
                      ),
                      SizedBox(height: 32),
                      passwordConstraints(),
                      SizedBox(height: 40),
                      FullWidthButton(
                        icon: Icons.arrow_forward,
                        labelText: l10n.change,
                        onPressed: () {
                          change();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          BlocSelector<ForgotPasswordCubit, ForgotPasswordState, bool>(
            selector: (state) {
              return state is ForgotPasswordLoading;
            },
            builder: (context, state) {
              return LoadingView(show: state);
            },
          ),
        ],
      ),
    );
  }

  void change() {
    if (_formKey.currentState!.validate() && constraintController.allValid()) {
      widget.cubit.changePassword(
        email: widget.email,
        password: passwordController.text,
      );
    }
  }

  Widget passwordConstraints() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: .start,
        spacing: 16,
        children: constraintController.constraints!
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
