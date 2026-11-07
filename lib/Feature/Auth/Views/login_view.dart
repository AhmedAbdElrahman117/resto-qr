import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Utils/assets.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Utils/toast.dart';
import 'package:resto_qr/Core/Widgets/full_width_button.dart';
import 'package:resto_qr/Core/Widgets/loading_view.dart';
import 'package:resto_qr/Core/Widgets/logo_box.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Login%20Cubit/login_cubit.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Login%20Cubit/login_state.dart';
import 'package:resto_qr/Feature/Auth/Widgets/create_account_button.dart';
import 'package:resto_qr/Feature/Auth/Widgets/email_text_field.dart';
import 'package:resto_qr/Feature/Auth/Widgets/forgot_password_button.dart';
import 'package:resto_qr/Feature/Auth/Widgets/password_text_field.dart';
import 'package:resto_qr/Feature/Home/Views/home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  final TextEditingController emailController = .new();
  final TextEditingController passwordController = .new();

  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode emailFocus = .new();
  final FocusNode passwordFocus = .new();

  late final AnimationController _sheetController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 750),
  );

  late final AnimationController _logoController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );

  @override
  void initState() {
    super.initState();
    _logoController.forward();
    _sheetController.forward();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    _sheetController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          if (state.openHome) {
            Navigation().pushReplacement(context, HomeView());
          }
        } else if (state is LoginFailed) {
          Toast().showError(
            title: l10n.loginFailed,
            description: state.message,
          );
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppTheme().primaryBackground(context),
                    AppTheme()
                        .primaryBackground(context)
                        .withValues(alpha: 0.86),
                  ],
                ),
              ),
              child: SafeArea(
                child: CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Expanded(
                            child:
                                Padding(
                                      padding: const .fromLTRB(24, 32, 24, 28),
                                      child: Column(
                                        mainAxisAlignment: .center,
                                        children: [
                                          LogoBox(
                                            padding: 22,
                                            radius: 18,
                                            child: SvgPicture.asset(
                                              Assets.imagesLoginLogo,
                                              width: 40,
                                            ),
                                          ),
                                          const SizedBox(height: 22),
                                          Text(
                                            'RestQR',
                                            style: AppText().bold26(context),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            l10n.restQrTagline,
                                            style: AppText().regular14(context),
                                          ),
                                        ],
                                      ),
                                    )
                                    .animate(
                                      controller: _logoController,
                                      autoPlay: false,
                                    )
                                    .fadeIn(
                                      delay: const Duration(milliseconds: 250),
                                      duration: _logoController.duration,
                                    ),
                          ),
                          Align(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 560),
                              child: Material(
                                elevation: 24,
                                color: AppTheme().sheetColor(context),
                                shape: RoundedRectangleBorder(
                                  borderRadius: const .only(
                                    topLeft: .circular(28),
                                    topRight: .circular(28),
                                  ),
                                  side: .new(
                                    color: AppTheme().borderColor(context),
                                    width: 1.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: const .fromLTRB(24, 14, 24, 30),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: .min,
                                      children: [
                                        Container(
                                          width: 42,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: AppTheme().borderColor(
                                              context,
                                            ),
                                            borderRadius: .circular(4),
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        Align(
                                          alignment: .centerLeft,
                                          child: Text(
                                            l10n.welcomeBack,
                                            style: AppText().bold24(context),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Align(
                                          alignment: .centerLeft,
                                          child: Text(
                                            l10n.signInToContinue,
                                            style: AppText().regular14(context),
                                          ),
                                        ),
                                        const SizedBox(height: 28),
                                        EmailTextField(
                                          controller: emailController,
                                          focusNode: emailFocus,
                                          nextFocus: passwordFocus,
                                        ),
                                        const SizedBox(height: 20),
                                        PasswordTextField(
                                          controller: passwordController,
                                          focusNode: passwordFocus,
                                          onFieldSubmitted: login,
                                        ),
                                        const SizedBox(height: 16),
                                        const Align(
                                          alignment: .centerRight,
                                          child: ForgotPasswordButton(),
                                        ),
                                        const SizedBox(height: 24),
                                        FullWidthButton(
                                          labelText: l10n.login,
                                          icon: Icons.login_rounded,
                                          onPressed: login,
                                        ),
                                        const SizedBox(height: 28),
                                        const CreateAccountButton(),
                                        const SizedBox(height: 14),
                                        Row(
                                          mainAxisAlignment: .center,
                                          children: [
                                            Icon(
                                              Icons.verified_user_outlined,
                                              size: 16,
                                              color:
                                                  AppConstants().successColor,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              l10n.secureAccountAccess,
                                              style: AppText().smallTag(
                                                context,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            BlocSelector<LoginCubit, LoginState, bool>(
              selector: (state) => state is LoginLoading,
              builder: (context, isLoading) {
                return LoadingView(show: isLoading);
              },
            ),
          ],
        ),
      ),
    );
  }

  void login() {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().loginWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }
}
