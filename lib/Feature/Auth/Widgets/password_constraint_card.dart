import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';

class PasswordConstraintCard extends StatelessWidget {
  const PasswordConstraintCard({
    super.key,
    required this.constraint,
    required this.text,
  });

  final bool? constraint;
  final String text;

  // ── helpers ────────────────────────────────────────────────────────────────

  Color _bgColor(AppConstants c) {
    if (constraint == null) return Colors.transparent;
    return constraint!
        ? c.neonBlue.withValues(alpha: 0.1)
        : c.errorRed.withValues(alpha: 0.08);
  }

  Color _borderColor(AppConstants c, BuildContext context) {
    if (constraint == null) return AppTheme().borderColor(context);
    return constraint!
        ? c.neonBlue.withValues(alpha: 0.35)
        : c.errorRed.withValues(alpha: 0.4);
  }

  Color _iconColor(AppConstants c) {
    if (constraint == null) return Colors.grey;
    return constraint! ? c.neonBlue : c.errorRed;
  }

  IconData get _icon {
    if (constraint == null) return Icons.radio_button_unchecked_rounded;
    return constraint! ? Icons.check_circle_rounded : Icons.cancel_rounded;
  }

  // ── build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final c = AppConstants();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _bgColor(c),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor(c, context)),
      ),
      child: Row(
        spacing: 12,
        children: [
          // ── icon ────────────────────────────────────────────────────────────
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, anim) => ScaleTransition(
              scale: anim,
              child: FadeTransition(opacity: anim, child: child),
            ),
            child: Icon(
              _icon,
              key: ValueKey(constraint),
              color: _iconColor(c),
              size: 20,
            ),
          ),

          // ── label ───────────────────────────────────────────────────────────
          Expanded(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: AppText()
                  .regular14(context)
                  .copyWith(
                    color: constraint == null
                        ? AppTheme().secondaryText(context)
                        : constraint!
                        ? c.neonBlue
                        : c.errorRed,
                  ),
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}
