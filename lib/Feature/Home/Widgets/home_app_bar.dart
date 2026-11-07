import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Widgets/logo_box.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Login%20Cubit/login_cubit.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .center,
      children: [
        Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          spacing: 6,
          children: [
            Text(
              AppLocalization.of(context).welcomeBackHome,
              style: AppText().regular20(context),
            ),
            Text(
              context.watch<LoginCubit>().state.user.userName,
              style: AppText().bold20(context),
            ),
          ],
        ),
        Spacer(),
        LogoBox(
          radius: 50,
          showShadow: false,
          padding: 16,
          child: Icon(Icons.store, size: 26),
        ),
      ],
    );
  }
}
