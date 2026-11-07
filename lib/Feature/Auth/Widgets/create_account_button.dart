import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Sign%20Up%20Cubit/sign_up_cubit.dart';
import 'package:resto_qr/Feature/Auth/Views/sign_up_view.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return RichText(
      text: TextSpan(
        text: l10n.newToRestoQr,
        style: AppText().regular14(context),
        children: [
          TextSpan(
            text: l10n.createAnAccount,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigation().push(
                  context,
                  BlocProvider(
                    create: (context) => SignUpCubit(),
                    child: const SignUpView(),
                  ),
                );
              },
            style: AppText()
                .bold14(context)
                .copyWith(color: AppConstants().neonBlue),
          ),
        ],
      ),
    );
  }
}
