import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Feature/Auth/Views/forgot_password_view.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ForgotPasswordView(),
            ),
          );
        },
        child: Text(
          AppLocalization.of(context).forgotPassword,
          style: AppText()
              .regular14(context)
              .copyWith(color: AppConstants().neonBlue),
        ),
      ),
    );
  }
}
