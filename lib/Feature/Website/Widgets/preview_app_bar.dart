import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';

class PreviewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PreviewAppBar({super.key, required this.title, this.onPressed});

  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: [
        IconButton.filled(
          onPressed: onPressed,
          style: IconButton.styleFrom(
            backgroundColor: AppConstants().neonBlue,
            foregroundColor: Colors.white,
          ),
          icon: Icon(Icons.check),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
