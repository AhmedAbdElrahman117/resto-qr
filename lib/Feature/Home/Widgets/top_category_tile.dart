import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Widgets/custom_container.dart';
import 'package:resto_qr/Feature/Menu/Models/category_model.dart';

class TopCategoryTile extends StatelessWidget {
  const TopCategoryTile({
    super.key,
    required this.category,
    required this.rank,
  });

  final CategoryModel category;
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
        category.name,
        style: AppText().semiBold16(context),
      ),
      subtitle: Text(
        ' ${AppLocalization.of(context).itemsCount(
          AppLocalization.formatNumber(category.itemsCount, context: context),
        )}',
        style: AppText().caption(context),
      ),
      trailing: CustomContainer(
        padding: const .symmetric(horizontal: 12, vertical: 6),
        color: category.isVisible
            ? AppConstants().successColor
            : AppConstants().errorRed,
        borderRadius: 20,
        child: Text(
          category.isVisible
              ? AppLocalization.of(context).live
              : AppLocalization.of(context).hidden,
          style: AppText().semiBold14(context).copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
