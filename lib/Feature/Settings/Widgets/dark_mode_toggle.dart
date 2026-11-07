import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Cubit/app_cubit.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Widgets/custom_switch_tile.dart';

class DarkModeToggle extends StatelessWidget {
  const DarkModeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return CustomSwitchTile(
      title: l10n.darkMode,
      color: AppConstants().neonBlue,
      backgroundColor: AppTheme().fillColor(context),
      secondry: Container(
        padding: .all(12),
        decoration: BoxDecoration(
          color: AppConstants().neonBlue.withValues(alpha: 0.15),
          borderRadius: .circular(12),
        ),
        child: Icon(
          Icons.dark_mode,
          color: AppConstants().neonBlue,
        ),
      ),
      subtitle: l10n.darkModeDescription,
      border: BorderSide(
        color: AppTheme().borderColor(context),
        width: 2,
      ),
      initialValue: context.watch<AppCubit>().state.mode == ThemeMode.dark,
      onToggle: (value) {
        context.read<AppCubit>().toggleTheme();
      },
    );
  }
}
