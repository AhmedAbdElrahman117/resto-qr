import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/assets.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Widgets/success_view.dart';
import 'package:resto_qr/Feature/Home/Views/home_view.dart';

class SignUpSuccessView extends StatelessWidget {
  const SignUpSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SuccessView(
        image: Assets.imagesSucess,
        title: AppLocalization.of(context).accountCreated,
        message: AppLocalization.of(context).accountCreatedDescription,
        showButton: true,
        buttonIcon: Icons.arrow_forward,
        buttonTitle: AppLocalization.of(context).goToDashboard,
        onButtonPressed: () {
          Navigation().pushReplacement(context, HomeView());
        },
      ),
    );
  }
}
