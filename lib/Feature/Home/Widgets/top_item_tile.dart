import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Widgets/custom_container.dart';
import 'package:resto_qr/Feature/Menu/Models/item_model.dart';

class TopItemTile extends StatelessWidget {
  const TopItemTile({
    super.key,
    required this.rank,
    required this.item,
  });

  final ItemModel item;
  final String rank;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppTheme().fillColor(context),
      shape: RoundedRectangleBorder(
        borderRadius: .circular(12),
        side: BorderSide(
          color: AppTheme().borderColor(context),
          width: 2,
        ),
      ),
      leading: CircleAvatar(
        backgroundColor: AppConstants().neonBlue,
        child: Text(
          rank,
          style: AppText().semiBold16(context).copyWith(color: Colors.white),
        ),
      ),
      title: Text(
        item.name,
        style: AppText().semiBold16(context),
      ),
      subtitle: Text(
        AppLocalization.of(context).itemViewsCount(
          AppLocalization.formatNumber(item.viewsCount, context: context),
        ),
        style: AppText().caption(context),
      ),
      trailing: CustomContainer(
        padding: const .symmetric(horizontal: 12, vertical: 6),
        color: item.isVisible
            ? AppConstants().successColor
            : AppConstants().errorRed,
        borderRadius: 20,
        child: Text(
          item.isVisible
              ? AppLocalization.of(context).live
              : AppLocalization.of(context).hidden,
          style: AppText().semiBold14(context).copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
