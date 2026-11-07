import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Models/user_model.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Utils/toast.dart';
import 'package:resto_qr/Core/Widgets/full_width_button.dart';
import 'package:resto_qr/Core/Widgets/loading_view.dart';
import 'package:resto_qr/Feature/Auth/Helper/account_info_helper.dart';
import 'package:resto_qr/Feature/Auth/Helper/business_info_helper.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Login%20Cubit/login_cubit.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Sign%20Up%20Cubit/sign_up_cubit.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Sign%20Up%20Cubit/sign_up_state.dart';
import 'package:resto_qr/Feature/Auth/Views/otp_verification_view.dart';
import 'package:resto_qr/Feature/Auth/Views/sign_up_account_info.dart';
import 'package:resto_qr/Feature/Auth/Views/sign_up_business_info.dart';
import 'package:resto_qr/Feature/Auth/Views/sign_up_success_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final PageController pageController = .new();

  final AccountInfoHelper infoHelper = .new();
  final BusinessInfoHelper businessHelper = .new();

  final ValueNotifier<int> currentPage = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return BlocListener<SignUpCubit, SignUpState>(
      listener: listener,
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              leading: backButton(),
              title: ValueListenableBuilder<int>(
                valueListenable: currentPage,
                builder: (_, page, _) => Text(
                  page == 0 ? l10n.accountInfo : l10n.businessInfo,
                ),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                const SizedBox(height: 16),
                _stepIndicator(context),
                const SizedBox(height: 8),
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    onPageChanged: (value) {
                      currentPage.value = value;
                    },
                    children: [
                      SignUpAccountInfo(
                        accountInfoHelper: infoHelper,
                      ),
                      SignUpBusinessInfo(
                        businessInfoHelper: businessHelper,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SafeArea(
                  top: false,
                  child: switchPageButton(context),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),

          BlocSelector<SignUpCubit, SignUpState, bool>(
            selector: (state) => state is SignUpLoading,
            builder: (context, state) => LoadingView(show: state),
          ),
        ],
      ),
    );
  }

  Widget _stepIndicator(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return ValueListenableBuilder<int>(
      valueListenable: currentPage,
      builder: (_, page, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              _stepPill(
                context,
                index: 0,
                label: l10n.account,
                active: page >= 0,
                done: page > 0,
              ),
              Expanded(
                child: Divider(
                  color: page >= 1
                      ? AppConstants().neonBlue
                      : AppTheme().borderColor(context),
                  thickness: 2,
                ),
              ),
              _stepPill(
                context,
                index: 1,
                label: l10n.business,
                active: page >= 1,
                done: false,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _stepPill(
    BuildContext context, {
    required int index,
    required String label,
    required bool active,
    required bool done,
  }) {
    final color = active
        ? AppConstants().neonBlue
        : AppTheme().secondaryText(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: active
                ? AppConstants().neonBlue
                : AppTheme().fillColor(context),
            shape: BoxShape.circle,
            border: Border.all(
              color: active
                  ? AppConstants().neonBlue
                  : AppTheme().borderColor(context),
            ),
          ),
          child: Center(
            child: done
                ? const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 14,
                  )
                : Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: active
                          ? Colors.white
                          : AppTheme().secondaryText(context),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppText().semiBold14(context).copyWith(color: color),
        ),
      ],
    );
  }

  void listener(BuildContext context, SignUpState state) {
    if (state is SignUpSucces) {
      context.read<LoginCubit>().quickLogin(user: state.user, openHome: false);
      Navigation().pushReplacement(context, SignUpSuccessView());
    } else if (state is SignUpFailed) {
      Toast().showError(
        title: AppLocalization.of(context).signUpFailed,
        description: state.message,
      );
    }
  }

  Widget switchPageButton(BuildContext context) {
    return FullWidthButton(
      icon: Icons.arrow_forward_ios_rounded,
      label: ValueListenableBuilder(
        valueListenable: currentPage,
        builder: (context, value, child) {
          return Text(
            value > 0
                ? AppLocalization.of(context).verifyEmail
                : AppLocalization.of(context).next,
            style: AppText().semiBold16(context, Colors.white),
          );
        },
      ),
      onPressed: () async {
        if (currentPage.value == 0) {
          checkFirstPage();
        } else if (currentPage.value == 1) {
          await checkSecondPage(context);
        }
      },
    );
  }

  Future<void> checkSecondPage(BuildContext context) async {
    if (businessHelper.validateFields()) {
      var done = await Navigation().push(
        context,
        OtpVerificationView(
          email: infoHelper.emailController.text,
          onError: (message) {
            log(message);
          },
        ),
      );
      if (done == true) {
        // ignore: use_build_context_synchronously
        await context.read<SignUpCubit>().signUp(
          user: createModel(),
          password: infoHelper.passwordController.text,
          imagePath: businessHelper.image,
        );
      }
    }
  }

  void checkFirstPage() {
    infoHelper.constraintController.checkPassword();
    if (infoHelper.validateFields()) {
      pageController.nextPage(
        duration: .new(milliseconds: 250),
        curve: Curves.linear,
      );
    }
  }

  Widget backButton() {
    return ValueListenableBuilder(
      valueListenable: currentPage,
      builder: (context, value, child) => BackButton(
        onPressed: value > 0
            ? () {
                pageController.previousPage(
                  duration: .new(milliseconds: 250),
                  curve: Curves.linear,
                );
              }
            : null,
      ),
    );
  }

  UserModel createModel() {
    return .new(
      email: infoHelper.emailController.text,
      userName: infoHelper.nameController.text,
      phone: infoHelper.phoneController.text,
      restaurantName: businessHelper.nameController.text,
      restaurantAddress: businessHelper.addressController.text,
      restaurantdescription: businessHelper.descriptionController.text,
      createdAt: DateTime.now(),
      lat: businessHelper.selectedPlace!.lat,
      lng: businessHelper.selectedPlace!.lng,
    );
  }
}
