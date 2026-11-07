import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_dialogs.dart';
import 'package:resto_qr/Core/Utils/app_extensions.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Widgets/cached_image.dart';
import 'package:resto_qr/Core/Widgets/custom_container.dart';
import 'package:resto_qr/Feature/Menu/Dialogs/offer_control_menu.dart';
import 'package:resto_qr/Feature/Menu/Models/offer_model.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Offer%20Cubit/offer_cubit.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({super.key, required this.offer});

  final OfferModel offer;

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
            barrierDismissible: false,
            child: BlocProvider.value(
              value: context.read<OfferCubit>(),
              child: OfferControlMenu(offer: offer),
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
                  url: offer.imageUrl,
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
                            offer.name,
                            style: AppText().semiBold16(context),
                            maxLines: 1,
                            overflow: .ellipsis,
                          ),
                        ),

                        const SizedBox(width: 8),

                        CustomContainer(
                          padding: const .symmetric(horizontal: 6, vertical: 2),
                          color: offer.isVisible
                              ? Colors.green.withValues(alpha: 0.15)
                              : Colors.grey.withValues(alpha: 0.15),
                          borderColor: Colors.transparent,
                          borderRadius: 4,
                          child: Text(
                            offer.isVisible
                                ? AppLocalization.of(context).live
                                : AppLocalization.of(context).hidden,
                            style: AppText()
                                .bold14(context)
                                .copyWith(
                                  color: offer.isVisible
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                          ),
                        ),
                      ],
                    ),

                    Text(
                      offer.description,
                      style: AppText().caption(context),
                      maxLines: 2,
                      overflow: .ellipsis,
                    ),

                    const SizedBox(height: 4),

                    if (offer.startsAt != null)
                      expiryDateWidget(
                        context: context,
                        date: offer.startsAt!,
                        prefix: 'Starts',
                      ),

                    if (offer.startsAt != null && offer.endsAt != null)
                      const SizedBox(height: 4),

                    if (offer.endsAt != null)
                      expiryDateWidget(context: context, date: offer.endsAt!),

                    const SizedBox(height: 4),

                    GridView.builder(
                      itemCount: offer.items.length,
                      shrinkWrap: true,
                      padding: .zero,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 12,
                            childAspectRatio: 4.0,
                          ),
                      itemBuilder: (context, index) => Text(
                        offer.items[index].name,
                        style: AppText().caption(context),
                        maxLines: 1,
                        overflow: .ellipsis,
                      ),
                    ),
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

  Row expiryDateWidget({
    required BuildContext context,
    required DateTime date,
    String prefix = 'Expires',
  }) {
    return Row(
      children: [
        const Icon(
          Icons.timer_outlined,
          size: 14,
          color: Colors.orange,
        ),

        const SizedBox(width: 4),

        Text(
          '$prefix: ${date.toDateTimeShort()}',
          style: AppText()
              .caption(context)
              .copyWith(color: Colors.orange, fontSize: 12),
        ),
      ],
    );
  }
}
