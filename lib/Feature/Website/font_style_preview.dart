import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Widgets/custom_container.dart';
import 'package:resto_qr/Core/Widgets/loading_scaffold.dart';
import 'package:resto_qr/Feature/Website/View%20Model/website_cubit.dart';
import 'package:resto_qr/Feature/Website/View%20Model/website_state.dart';
import 'package:resto_qr/Feature/Website/Widgets/font_style_option.dart';
import 'package:resto_qr/Feature/Website/Widgets/preview_app_bar.dart';

class FontStylePreview extends StatefulWidget {
  const FontStylePreview({super.key});

  @override
  State<FontStylePreview> createState() => _FontStylePreviewState();
}

class _FontStylePreviewState extends State<FontStylePreview> {
  late final ValueNotifier<String> _currentFont;

  Map<String, String> fontOptions(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return {
      'Roboto': l10n.fontModern,
      'Open Sans': l10n.fontClean,
      'Lato': l10n.fontElegant,
    };
  }

  @override
  void initState() {
    _currentFont = ValueNotifier<String>(
      context.read<WebsiteCubit>().currentTheme.fontFamily,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return LoadingScaffold<WebsiteCubit, WebsiteState>(
      appBar: PreviewAppBar(
        title: l10n.fontStylePreview,
        onPressed: () {
          context.read<WebsiteCubit>().update(fontFamily: _currentFont.value);
        },
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const .symmetric(vertical: 24, horizontal: 16),
        children: [
          Text(l10n.preview, style: AppText().semiBold16(context)),

          const SizedBox(height: 4),

          Text(
            l10n.fontStylePreviewDescription,
            style: AppText().caption(context),
          ),

          const SizedBox(height: 12),

          CustomContainer(
            padding: const .all(20),
            child: ValueListenableBuilder(
              valueListenable: _currentFont,
              builder: (context, value, _) {
                return Column(
                  crossAxisAlignment: .start,
                  spacing: 8,
                  children: [
                    Text(
                      l10n.quickBrownFox,
                      style: AppText()
                          .bold24(context)
                          .copyWith(fontFamily: value),
                    ),
                    Text(
                      l10n.grilledSalmon,
                      style: AppText()
                          .semiBold16(context)
                          .copyWith(fontFamily: value),
                    ),
                    Text(
                      l10n.salmonDescription,
                      style: AppText()
                          .caption(context)
                          .copyWith(fontFamily: value),
                    ),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 32),

          Text(l10n.selectFont, style: AppText().semiBold16(context)),

          const SizedBox(height: 4),

          Text(
            l10n.chooseTypography,
            style: AppText().caption(context),
          ),

          const SizedBox(height: 12),

          ValueListenableBuilder(
            valueListenable: _currentFont,
            builder: (context, value, _) {
              return RadioGroup(
                onChanged: (v) => _currentFont.value = v!,
                groupValue: value,
                child: Column(
                  spacing: 12,
                  children: fontOptions(context).entries
                      .map(
                        (e) => FontStyleOption(
                          titleAndValue: e.key,
                          description: e.value,
                          isSelected: value == e.key,
                        ),
                      )
                      .toList(),
                ),
              );
            },
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
