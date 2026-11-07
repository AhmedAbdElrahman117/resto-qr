import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_dialogs.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Utils/app_extensions.dart';
import 'package:resto_qr/Core/Widgets/cached_image.dart';
import 'package:resto_qr/Core/Widgets/custom_container.dart';
import 'package:resto_qr/Feature/Menu/Models/item_model.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Item%20Cubit/item_cubit.dart';
import 'package:resto_qr/Feature/Menu/Widgets/item_control_menu.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item});

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme().fillColor(context),
      shape: RoundedRectangleBorder(
        borderRadius: .circular(12),
        side: BorderSide(color: AppTheme().borderColor(context), width: 2),
      ),
      child: InkWell(
        borderRadius: .circular(12),
        onTap: () {
          AppDialogs().showDialog(
            context: context,
            child: BlocProvider.value(
              value: context.read<ItemCubit>(),
              child: ItemControlMenu(item: item),
            ),
          );
        },
        child: Padding(
          padding: const .all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: .circular(10),
                child: CachedImage(
                  width: 90,
                  height: 90,
                  fit: .cover,
                  url: item.imageURL.first,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: 4,
                  children: [
                    Row(
                      crossAxisAlignment: .start,
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            style: AppText().semiBold16(context),
                            maxLines: 1,
                            overflow: .ellipsis,
                          ),
                        ),

                        const SizedBox(width: 8),

                        CustomContainer(
                          padding: const .symmetric(horizontal: 6, vertical: 2),
                          color: item.isVisible
                              ? Colors.green.withValues(alpha: 0.15)
                              : Colors.grey.withValues(alpha: 0.15),
                          borderColor: Colors.transparent,
                          borderRadius: 4,
                          child: Text(
                            item.isVisible
                                ? AppLocalization.of(context).live
                                : AppLocalization.of(context).hidden,
                            style: AppText()
                                .bold14(context)
                                .copyWith(
                                  color: item.isVisible
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                          ),
                        ),
                      ],
                    ),

                    Text(
                      item.description,
                      style: AppText().caption(context),
                      maxLines: 2,
                      overflow: .ellipsis,
                    ),

                    if (item.expiresAt != null) expiryDateWidget(context),

                    const SizedBox(height: 4),

                    discountWidget(context),
                  ],
                ),
              ),

              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppConstants().neonBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row discountWidget(BuildContext context) {
    return Row(
      children: [
        CustomContainer(
          padding: const .symmetric(horizontal: 8, vertical: 3),
          color: AppConstants().neonBlue.withValues(alpha: 0.12),
          borderColor: AppConstants().neonBlue.withValues(alpha: 0.12),
          borderRadius: 20,
          child: Text(
            (item.discount != null && item.discount!.isNotEmpty)
                ? '\$ ${AppLocalization.formatNumber(num.parse(item.discount!), context: context)}'
                : '\$ ${AppLocalization.formatNumber(num.parse(item.price), context: context)}',
            style: AppText().semiBold14(context, AppConstants().neonBlue),
          ),
        ),

        if (item.discount != null && item.discount!.isNotEmpty) ...[
          const SizedBox(width: 8),
          Text(
            '\$${item.price}',
            style: AppText()
                .caption(context)
                .copyWith(decoration: .lineThrough),
          ),
        ],
      ],
    );
  }

  Row expiryDateWidget(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.timer_outlined,
          size: 14,
          color: Colors.orange,
        ),

        const SizedBox(width: 4),

        Text(
          AppLocalization.of(context).expires(
            item.expiresAt!.toDateTimeShort(),
          ),
          style: AppText()
              .caption(context)
              .copyWith(color: Colors.orange, fontSize: 12),
        ),
      ],
    );
  }
}
