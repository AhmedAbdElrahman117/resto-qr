import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Utils/toast.dart';
import 'package:resto_qr/Core/Widgets/full_width_button.dart';
import 'package:resto_qr/Core/Widgets/loading_view.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Forgot%20Password%20Cubit/forgot_password_cubit.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Forgot%20Password%20Cubit/forgot_password_state.dart';
import 'package:resto_qr/Feature/Auth/Views/change_password_succes_view.dart';
import 'package:resto_qr/Feature/Auth/Views/change_password_view.dart';
import 'package:resto_qr/Feature/Auth/Views/otp_verification_view.dart';
import 'package:resto_qr/Feature/Auth/Widgets/email_text_field.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final GlobalKey<FormState> _formKey = .new();

  final TextEditingController emailController = .new();

  final ValueNotifier<bool> isEmpty = ValueNotifier(true);

  final ForgotPasswordCubit cubit = ForgotPasswordCubit();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return BlocProvider.value(
      value: cubit,
      child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: listener,
        child: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                leading: BackButton(),
              ),
              body: Form(
                key: _formKey,
                child: Center(
                  child: SingleChildScrollView(
                    padding: .all(20),
                    child: Column(
                      children: [
                        Text(
                          l10n.forgotPasswordTitle,
                          style: AppText().bold28(context),
                          textAlign: .start,
                        ),
                        SizedBox(height: 12),
                        Text(
                          l10n.forgotPasswordDescription,
                          style: AppText().regular16(context),
                          textAlign: .center,
                        ),
                        SizedBox(height: 36),
                        EmailTextField(
                          controller: emailController,
                          onChanged: (value) {
                            isEmpty.value = value.trim().isEmpty;
                          },
                          onFieldSubmitted: () {
                            check();
                          },
                        ),
                        SizedBox(height: 52),
                        verifyEmail(),
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
      ),
    );
  }

  void check() {
    if (_formKey.currentState!.validate()) {
      cubit.isUserExist(email: emailController.text);
    }
  }

  void listener(BuildContext context, ForgotPasswordState state) async {
    if (state is UserExist) {
      var done = await Navigation().push(
        context,
        OtpVerificationView(email: emailController.text),
      );
      log(done.toString());
      if (done == true) {
        Navigation().push(
          // ignore: use_build_context_synchronously
          context,
          ChangePasswordView(
            cubit: cubit,
            email: emailController.text,
          ),
        );
      }
    } else if (state is UserNotExist) {
      Toast().showError(
        title: AppLocalization.of(context).emailNotFound,
        description: AppLocalization.of(context).emailNotFoundDescription,
      );
    } else if (state is PasswordChangeFailed) {
      Toast().showError(
        title: AppLocalization.of(context).error,
        description: state.message,
      );
    } else if (state is PasswordChangeSuccess) {
      Navigation().pushReplacement(context, ChangePasswordSuccesView());
    }
  }

  Widget verifyEmail() {
    return ValueListenableBuilder(
      valueListenable: isEmpty,
      builder: (context, value, child) {
        return FullWidthButton(
          icon: Icons.arrow_forward,
          labelText: AppLocalization.of(context).verify,
          onPressed: value
              ? null
              : () async {
                  check();
                },
        );
      },
    );
  }

  @override
  void dispose() {
    isEmpty.dispose();
    emailController.dispose();
    super.dispose();
  }
}
