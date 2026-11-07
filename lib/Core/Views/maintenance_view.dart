import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/assets.dart';
import 'package:resto_qr/Core/Widgets/universal_image.dart';

class MaintenanceView extends StatelessWidget {
  const MaintenanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Flexible(
              child: UniversalImage(
                source: Assets.imagesMaintenance,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'App Under Maintenance',
              style: AppText().bold24(context),
              textAlign: .center,
            ),

            const SizedBox(height: 16),

            Text(
              'We are currently upgrading the app to bring you a faster and smoother experience. Thanks for your patience—we will be back up and running very soon!.',
              style: AppText().regular18(context),
              textAlign: .center,
            ),
          ],
        ),
      ),
    );
  }
}
