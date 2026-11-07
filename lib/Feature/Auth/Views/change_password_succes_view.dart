import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/assets.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Widgets/success_view.dart';
import 'package:resto_qr/Feature/Auth/Views/login_view.dart';

class ChangePasswordSuccesView extends StatelessWidget {
  const ChangePasswordSuccesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SuccessView(
        title: AppLocalization.of(context).passwordChanged,
        message: AppLocalization.of(context).passwordChangedDescription,
        image: Assets.imagesSuccess1,
        showButton: true,
        buttonTitle: AppLocalization.of(context).goToLogin,
        buttonIcon: Icons.login,
        onButtonPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => LoginView(),
            ),
            (route) => false,
          );
        },
      ),
    );
  }
}
