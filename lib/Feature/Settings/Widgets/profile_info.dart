import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Models/user_model.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/assets.dart';
import 'package:resto_qr/Core/Widgets/custom_container.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key, required this.info});

  final UserModel info;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: const .all(12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: info.restaurantLogoURL != null
              ? CachedNetworkImageProvider(
                  info.restaurantLogoURL!,
                )
              : const AssetImage(Assets.imagesNoImageAvailable),
          maxRadius: 28,
          backgroundColor: AppConstants().neonBlue,
        ),
        title: Text(
          info.userName,
          style: AppText().bold18(context),
        ),
        subtitle: Text(
          info.restaurantName,
          style: AppText()
              .caption(context)
              .copyWith(color: AppConstants().neonBlue),
        ),
      ),
    );
  }
}
