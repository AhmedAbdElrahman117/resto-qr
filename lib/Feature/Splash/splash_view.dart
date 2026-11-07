import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:resto_qr/Core/Cubit/app_cubit.dart';
import 'package:resto_qr/Core/Models/user_model.dart';
import 'package:resto_qr/Core/Services/supabase_db.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_dialogs.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Widgets/loading_widget.dart';
import 'package:resto_qr/Core/Widgets/type_writer_text.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Login%20Cubit/login_cubit.dart';
import 'package:resto_qr/Feature/Auth/Views/login_view.dart';
import 'package:resto_qr/Feature/Home/Views/home_view.dart';
import 'package:resto_qr/Feature/Onboarding/onboarding_view.dart';
import 'package:resto_qr/Feature/Splash/Dialogs/update_dialog.dart';
import 'package:resto_qr/Feature/Splash/Model/version_model.dart';
import 'package:resto_qr/Feature/Splash/Widgets/splash_logo.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  final GlobalKey<TypewriterTextState> _typewriterKey =
      GlobalKey<TypewriterTextState>();

  late final AnimationController shimmerController;
  late final AnimationController logoFadeController;
  late final AnimationController loadingFadeController;

  @override
  void initState() {
    logoFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    shimmerController = AnimationController(vsync: this);

    loadingFadeController = AnimationController(vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 40,
          children: [
            SplashLogo()
                .animate(
                  controller: logoFadeController,
                  autoPlay: false,
                  onComplete: (controller) {
                    _typewriterKey.currentState?.start();
                  },
                )
                .scaleXY(
                  begin: 0.9,
                  end: 1.0,
                )
                .fadeIn()
                .animate(
                  controller: shimmerController,
                  autoPlay: false,
                )
                .shimmer(
                  angle: 120,
                  duration: const Duration(milliseconds: 1200),
                  delay: const Duration(milliseconds: 400),
                  color: AppConstants().neonBlue.withValues(alpha: 0.4),
                ),

            TypewriterText(
              key: _typewriterKey,
              text: 'RestoQR',
              style: AppText().bold28(context, AppConstants().neonBlue),
              duration: const Duration(milliseconds: 1200),
              autoStart: false,
              onComplete: () {
                shimmerController.repeat();
                loadingFadeController.forward();
              },
            ),

            LoadingWidget()
                .animate(
                  controller: loadingFadeController,
                  autoPlay: false,
                  onComplete: (controller) async {
                    await Future.delayed(
                      const Duration(milliseconds: 500),
                      () async {
                        if (context.mounted) {
                          checkRoute(context);
                        }
                      },
                    );
                  },
                )
                .fadeIn(
                  duration: const Duration(milliseconds: 750),
                ),
          ],
        ),
      ),
    );
  }

  Future<void> checkRoute(BuildContext context) async {
    bool showOnboarding = context.read<AppCubit>().state.showOnboarding;

    bool showLogin = context.read<LoginCubit>().state.user == const EmptyUser();

    await checkVersion();

    if (context.mounted) {
      if (showOnboarding) {
        Navigation().pushReplacement(context, OnboardingView());
      } else {
        if (showLogin) {
          Navigation().pushReplacement(context, LoginView());
        } else {
          Navigation().pushReplacement(context, HomeView());
        }
      }
    }
  }

  Future<PackageInfo> getCurrentVersion() async {
    return await PackageInfo.fromPlatform();
  }

  Future<VersionModel?> getLatestVersion() async {
    final res = await SupabaseDb()
        .get(table: 'versions')
        .select('*')
        .order('created_at', ascending: false)
        .limit(1)
        .single();

    return res.isNotEmpty ? VersionModel.fromJson(res) : null;
  }

  Future<void> checkVersion() async {
    try {
      final res = await Future.wait([
        getCurrentVersion(),
        getLatestVersion(),
      ]);

      var currentVersion = res[0] as PackageInfo;
      var latestVersion = res[1] as VersionModel?;

      if (latestVersion != null &&
          currentVersion.version != latestVersion.version) {
        if (mounted) {
          AppDialogs().showDialog(
            context: context,
            child: UpdateDialog(
              isMandatory: latestVersion.isMandatory,
              updateUrl: latestVersion.url,
            ),
          );
        }
      } else {
        return;
      }
    } catch (e) {
      return;
    }
  }

  @override
  void dispose() {
    shimmerController.dispose();
    logoFadeController.dispose();
    loadingFadeController.dispose();
    super.dispose();
  }
}
