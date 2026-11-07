import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/assets.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Widgets/universal_image.dart';
import 'package:resto_qr/Feature/Splash/splash_view.dart';

class AppCrashView extends StatelessWidget {
  const AppCrashView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const .symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Flexible(
              child: UniversalImage(
                source: Assets.imagesErrorScreen,
              ),
            ),

            const SizedBox(height: 40),

            Text(
              'We\'re sorry, something went wrong',
              textAlign: .center,
              style: AppText().bold24(context),
            ),

            const SizedBox(height: 20),

            Text(
              'We are having trouble displaying this page. Our engineering team has been notified and is working on it',
              textAlign: .center,
              style: AppText().regular18(context),
            ),

            const SizedBox(height: 36),

            ElevatedButton(
              onPressed: () {
                Navigation().pushReplacement(context, SplashView());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants().neonBlue,
                padding: const .symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: Text(
                'Restart App',
                style: AppText().bold16(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
