import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Cubit/app_cubit.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Widgets/full_width_button.dart';
import 'package:resto_qr/Feature/Auth/Views/login_view.dart';

class PageSwitchButton extends StatelessWidget {
  const PageSwitchButton({
    super.key,
    this.onPressed,
    required this.pageController,
    required this.isLastPage,
  });

  final void Function()? onPressed;
  final PageController pageController;
  final ValueNotifier<bool> isLastPage;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isLastPage,
      builder: (context, value, child) {
        final l10n = AppLocalization.of(context);
        return FullWidthButton(
          label: Text(
            value ? l10n.getStarted : l10n.next,
            style: AppText().semiBold16(context, Colors.white),
          ),
          icon: Icons.arrow_forward,
          onPressed: value
              ? () {
                  context.read<AppCubit>().disableOnboarding();

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginView(),
                    ),
                  );
                }
              : () {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                  );
                },
        );
      },
    );
  }
}
