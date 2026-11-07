import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';

class ShareOptionsSheet extends StatelessWidget {
  const ShareOptionsSheet({
    super.key,
    this.onShareURL,
    this.onShareImage,
  });

  final VoidCallback? onShareURL;
  final VoidCallback? onShareImage;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return Padding(
      padding: const .symmetric(
        horizontal: 20,
      ),
      child: Column(
        spacing: 4,
        mainAxisSize: .min,
        children: [
          optionTile(
            title: l10n.shareUrl,
            icon: Icons.link_rounded,
            onTap: onShareURL,
          ),

          optionTile(
            title: l10n.shareQrCodeImage,
            icon: Icons.image,
            onTap: onShareImage,
          ),

          SizedBox(height: 32),
        ],
      ),
    );
  }

  ListTile optionTile({
    required String title,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16),
      shape: RoundedRectangleBorder(
        borderRadius: .circular(12),
      ),
      onTap: onTap,
    );
  }
}
