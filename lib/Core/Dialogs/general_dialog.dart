import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Dialogs/dialog_cancel_button.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/assets.dart';
import 'package:resto_qr/Core/Widgets/custom_dialog.dart';
import 'package:resto_qr/Core/Widgets/universal_image.dart';

class GeneralDialog extends StatelessWidget {
  const GeneralDialog({
    super.key,
    required this.onConfirm,
    this.title,
    this.message,
    this.image,
    this.confirmButtonLabel,
    this.confirmButtonIcon,
  });

  final void Function(BuildContext dialogContext) onConfirm;
  final String? title;
  final String? message;
  final String? image;
  final String? confirmButtonLabel;
  final IconData? confirmButtonIcon;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      padding: .symmetric(vertical: 24, horizontal: 20),
      child: Column(
        mainAxisSize: .min,
        children: [
          UniversalImage(
            source: image ?? Assets.imagesDelete,
            height: 160,
          ),

          const SizedBox(height: 32),

          Text(
            title ?? AppLocalization.current.deleteItem,
            style: AppText().bold24(context),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          Text(
            message ?? AppLocalization.current.deleteItemConfirmation,
            style: AppText().regular18(context),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: .spaceAround,
            children: [
              DialogCancelButton(),
              TextButton.icon(
                onPressed: () => onConfirm(context),
                label: Text(
                  confirmButtonLabel ?? AppLocalization.current.delete,
                  style: AppText().bold16(context, Colors.white),
                ),
                icon: Icon(
                  confirmButtonIcon ?? Icons.delete_outline_rounded,
                  color: Colors.white,
                ),
                style: TextButton.styleFrom(
                  backgroundColor: AppConstants().errorRed,
                  elevation: 0,
                  padding: const .symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
