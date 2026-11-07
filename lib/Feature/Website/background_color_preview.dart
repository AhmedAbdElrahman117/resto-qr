import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Widgets/custom_container.dart';
import 'package:resto_qr/Core/Widgets/loading_scaffold.dart';
import 'package:resto_qr/Feature/Website/View%20Model/website_cubit.dart';
import 'package:resto_qr/Feature/Website/View%20Model/website_state.dart';
import 'package:resto_qr/Feature/Website/Widgets/color_palette_widget.dart';
import 'package:resto_qr/Feature/Website/Widgets/preview_app_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BackgroundColorPreview extends StatefulWidget {
  const BackgroundColorPreview({super.key});

  @override
  State<BackgroundColorPreview> createState() => _BackgroundColorPreviewState();
}

class _BackgroundColorPreviewState extends State<BackgroundColorPreview> {
  late final ValueNotifier<Color> _currentColor;

  @override
  void initState() {
    _currentColor = ValueNotifier(
      context.read<WebsiteCubit>().currentTheme.backgroundColor,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return LoadingScaffold<WebsiteCubit, WebsiteState>(
      appBar: PreviewAppBar(
        title: l10n.backgroundColorPreview,
        onPressed: () {
          context.read<WebsiteCubit>().update(
            backgroundColor: _currentColor.value,
          );
        },
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const .symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.preview, style: AppText().semiBold16(context)),

            const SizedBox(height: 4),

            Text(
              l10n.backgroundColorPreviewDescription,
              style: AppText().caption(context),
            ),

            const SizedBox(height: 12),

            ValueListenableBuilder(
              valueListenable: _currentColor,
              builder: (context, color, _) {
                return previewBox(color, context);
              },
            ),

            const SizedBox(height: 32),

            Row(
              children: [
                Text(l10n.pickAColor, style: AppText().semiBold16(context)),

                const Spacer(),

                ValueListenableBuilder(
                  valueListenable: _currentColor,
                  builder: (context, color, _) {
                    return colorCirclePreview(color);
                  },
                ),
              ],
            ),

            const SizedBox(height: 4),

            Text(
              l10n.chooseBackgroundColor,
              style: AppText().caption(context),
            ),

            const SizedBox(height: 12),

            ColorPaletteWidget(primaryColor: _currentColor),
          ],
        ),
      ),
    );
  }

  CustomContainer previewBox(Color color, BuildContext context) {
    return CustomContainer(
      color: color,
      padding: const .all(20),
      width: .infinity,
      child: Skeletonizer(
        enabled: true,
        child: Column(
          mainAxisSize: .min,
          spacing: 10,
          crossAxisAlignment: .start,
          mainAxisAlignment: .spaceEvenly,
          children: List.generate(
            4,
            (index) => Text(
              AppLocalization.of(context).previewBackgroundColor,
              style: AppText().bold20(context),
            ),
          ),
        ),
      ),
    );
  }

  Container colorCirclePreview(Color color) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        shape: .circle,
        border: .all(
          color: AppConstants().neonBlue.withValues(alpha: 0.4),
          width: 2,
        ),
      ),
    );
  }
}
