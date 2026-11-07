import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Widgets/custom_container.dart';
import 'package:resto_qr/Core/Widgets/loading_scaffold.dart';
import 'package:resto_qr/Feature/Website/View%20Model/website_cubit.dart';
import 'package:resto_qr/Feature/Website/View%20Model/website_state.dart';
import 'package:resto_qr/Feature/Website/Widgets/color_palette_widget.dart';
import 'package:resto_qr/Feature/Website/Widgets/preview_app_bar.dart';

class PrimaryColorPreview extends StatefulWidget {
  const PrimaryColorPreview({super.key});

  @override
  State<PrimaryColorPreview> createState() => _PrimaryColorPreviewState();
}

class _PrimaryColorPreviewState extends State<PrimaryColorPreview> {
  late final ValueNotifier<Color> _primaryColor;

  @override
  void initState() {
    _primaryColor = ValueNotifier<Color>(
      context.read<WebsiteCubit>().currentTheme.primaryColor,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return LoadingScaffold<WebsiteCubit, WebsiteState>(
      appBar: PreviewAppBar(
        title: l10n.primaryColorPreview,
        onPressed: () {
          context.read<WebsiteCubit>().update(
            primaryColor: _primaryColor.value,
          );
        },
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const .symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(l10n.preview, style: AppText().semiBold16(context)),

            const SizedBox(height: 4),

            Text(
              l10n.primaryColorPreviewDescription,
              style: AppText().caption(context),
            ),

            const SizedBox(height: 12),

            CustomContainer(
              padding: const EdgeInsets.all(20),
              child: ValueListenableBuilder(
                valueListenable: _primaryColor,
                builder: (context, color, _) {
                  return Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 8,
                          children: [
                            Icon(
                              Icons.sell_rounded,
                              color: color,
                              size: 28,
                            ),
                            Text(
                              '\$12.99',
                              style: AppText()
                                  .bold20(context)
                                  .copyWith(color: color),
                            ),
                            Text(
                              l10n.priceTag,
                              style: AppText().caption(context),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 8,
                          children: [
                            previewButton(color, context),
                            Text(
                              l10n.actionButton,
                              style: AppText().caption(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 32),

            Text(l10n.pickAColor, style: AppText().semiBold16(context)),

            const SizedBox(height: 4),

            Text(
              l10n.choosePrimaryColor,
              style: AppText().caption(context),
            ),

            const SizedBox(height: 12),

            ColorPaletteWidget(primaryColor: _primaryColor),
          ],
        ),
      ),
    );
  }

  ElevatedButton previewButton(Color color, BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
      ),
      child: Text(
        AppLocalization.of(context).orderNow,
        style: AppText().semiBold14(
          context,
          Colors.white,
        ),
      ),
    );
  }
}
