import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Widgets/custom_switch_tile.dart';

class CustomerVisibilitySwitch extends StatelessWidget {
  const CustomerVisibilitySwitch({
    super.key,
    required this.onToggle,
    required this.initialValue,
  });

  final void Function(bool value) onToggle;
  final bool initialValue;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return CustomSwitchTile(
      title: l10n.visibleToCustomers,
      subtitle: l10n.visibleToCustomersDescription,
      color: AppConstants().neonBlue,
      backgroundColor: AppTheme().fillColor(context),
      secondry: Container(
        padding: .all(12),
        decoration: BoxDecoration(
          color: AppConstants().neonBlue.withValues(alpha: 0.15),
          borderRadius: .circular(12),
        ),
        child: Icon(Icons.visibility, color: AppConstants().neonBlue),
      ),
      border: BorderSide(
        color: AppTheme().borderColor(context),
        width: 2,
      ),
      onToggle: onToggle,
      initialValue: initialValue,
    );
  }
}
