import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Dialogs/general_dialog.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_dialogs.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/assets.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Widgets/full_width_button.dart';
import 'package:resto_qr/Core/Widgets/loading_view.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Login%20Cubit/login_cubit.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Login%20Cubit/login_state.dart';
import 'package:resto_qr/Feature/Auth/Views/login_view.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color red = AppConstants().errorRed;

    return Center(
      child: FullWidthButton(
        label: Text(
          AppLocalization.of(context).signOut,
          style: AppText()
              .bold16(context)
              .copyWith(
                color: isDark ? red.withValues(alpha: 0.9) : red,
              ),
        ),
        backgroundColor: red.withValues(alpha: isDark ? 0.15 : 0.05),
        border: BorderSide(
          color: red.withValues(alpha: isDark ? 0.6 : 0.4),
          width: 1.5,
        ),
        icon: Icons.logout,
        iconColor: isDark ? red.withValues(alpha: 0.9) : red,
        iconAlignment: .start,
        onPressed: () async {
          AppDialogs().showDialog(
            context: context,
            child: BlocListener<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is SignOutSuccess) {
                  Navigation().pushReplacement(context, const LoginView());
                }
              },
              child: Stack(
                children: [
                  GeneralDialog(
                    confirmButtonLabel: AppLocalization.of(context).signOut,
                    title: l10n.signOutConfirmation,
                    message: l10n.signoutDescription,
                    image: Assets.imagesLogout,
                    confirmButtonIcon: Icons.logout,
                    onConfirm: (dialogContext) {
                      context.read<LoginCubit>().logout();
                    },
                  ),

                  BlocSelector<LoginCubit, LoginState, bool>(
                    selector: (state) {
                      return state is SignOutLoading;
                    },
                    builder: (context, state) {
                      return LoadingView(show: state);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
