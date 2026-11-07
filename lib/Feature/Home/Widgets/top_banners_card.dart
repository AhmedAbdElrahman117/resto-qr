import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Feature/Website/Banners/Models/banner_model.dart';

class TopBannersCard extends StatelessWidget {
  const TopBannersCard({
    super.key,
    required this.banner,
    required this.index,
    this.width,
  });

  final BannerModel banner;
  final int index;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: AppConstants().neonBlue.withValues(alpha: 0.1),
        borderRadius: .circular(12),
        image: DecorationImage(
          image: CachedNetworkImageProvider(banner.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        width: .infinity,
        height: .infinity,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.75),
          borderRadius: .circular(12),
        ),
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Text(
              'Promo Banner $index',
              style: AppText().bold16(context),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalization.of(context).bannerInteractions(
                AppLocalization.formatNumber(
                  banner.interactions,
                  context: context,
                ),
              ),
              style: AppText().semiBold16(context),
            ),
          ],
        ),
      ),
    );
  }
}
