import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Widgets/custom_container.dart';
import 'package:resto_qr/Core/Widgets/custom_slider.dart';
import 'package:resto_qr/Core/Widgets/custom_switch_tile.dart';
import 'package:resto_qr/Core/Widgets/loading_scaffold.dart';
import 'package:resto_qr/Feature/Website/View%20Model/website_cubit.dart';
import 'package:resto_qr/Feature/Website/View%20Model/website_state.dart';
import 'package:resto_qr/Feature/Website/Widgets/preview_app_bar.dart';

class CardRadiusPreview extends StatefulWidget {
  const CardRadiusPreview({super.key});

  @override
  State<CardRadiusPreview> createState() => _CardRadiusPreviewState();
}

class _CardRadiusPreviewState extends State<CardRadiusPreview> {
  late final ValueNotifier<double> _currentRadius;
  late final ValueNotifier<double> _currentElevation;
  late final ValueNotifier<bool> _elevationEnabled;

  @override
  void initState() {
    var elevation = context.read<WebsiteCubit>().currentTheme.cardElevation;
    _currentRadius = ValueNotifier(
      context.read<WebsiteCubit>().currentTheme.cardRadius.toDouble(),
    );

    _currentElevation = ValueNotifier(
      elevation.toDouble(),
    );

    _elevationEnabled = ValueNotifier(elevation != 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return LoadingScaffold<WebsiteCubit, WebsiteState>(
      appBar: PreviewAppBar(
        title: l10n.cardRadiusPreview,
        onPressed: () {
          context.read<WebsiteCubit>().update(
            cardRadius: _currentRadius.value.round(),
            cardElevation: _currentElevation.value.round(),
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
              l10n.cardRadiusPreviewDescription,
              style: AppText().caption(context),
            ),

            const SizedBox(height: 12),

            CustomContainer(
              padding: const .all(20),
              width: .infinity,
              height: 200,
              child: ListenableBuilder(
                listenable: Listenable.merge([
                  _currentRadius,
                  _currentElevation,
                  _elevationEnabled,
                ]),
                builder: (context, _) {
                  return Card(
                    elevation: _elevationEnabled.value
                        ? _currentElevation.value
                        : 0,
                    shadowColor: AppTheme().naturalShadowColor(context),
                    color: AppConstants().neonBlue.withAlpha(128),
                    shape: RoundedRectangleBorder(
                      borderRadius: .circular(_currentRadius.value),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 32),

            ValueListenableBuilder(
              valueListenable: _currentRadius,
              builder: (context, radius, _) => _sectionHeader(
                context,
                l10n.cardRadius,
                l10n.adjustCardCorners,
                badge: '${radius.round()}px',
              ),
            ),

            const SizedBox(height: 12),

            CustomContainer(
              child: CustomSlider(
                initialValue: _currentRadius.value,
                divisions: 8,
                min: 0,
                max: 32,
                onChanged: (v) => _currentRadius.value = v,
              ),
            ),

            const SizedBox(height: 32),

            ValueListenableBuilder(
              valueListenable: _currentElevation,
              builder: (context, elevation, _) => _sectionHeader(
                context,
                l10n.cardElevation,
                l10n.controlShadowDepth,
                badge: '${elevation.round()}px',
              ),
            ),

            const SizedBox(height: 12),

            CustomContainer(
              child: Column(
                children: [
                  shadowSwitch(),

                  shadowSlider(),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  CustomSwitchTile shadowSwitch() {
    return CustomSwitchTile(
      title: AppLocalization.of(context).enableShadow,
      showIcon: false,
      initialValue: _elevationEnabled.value,
      color: AppConstants().neonBlue,
      onToggle: (v) {
        if (v == false) {
          _currentElevation.value = 0;
        }
        _elevationEnabled.value = v;
      },
    );
  }

  ValueListenableBuilder<bool> shadowSlider() {
    return ValueListenableBuilder(
      valueListenable: _elevationEnabled,
      builder: (context, enabled, _) {
        return CustomSlider(
          key: UniqueKey(),
          initialValue: _currentElevation.value,
          divisions: 8,
          min: 0,
          max: 32,
          enable: enabled,
          onChanged: (v) => _currentElevation.value = v,
        );
      },
    );
  }

  Widget _sectionHeader(
    BuildContext context,
    String title,
    String description, {
    String? badge,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: AppText().semiBold16(context)),
            if (badge != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const .symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppConstants().neonBlue.withValues(alpha: 0.12),
                  borderRadius: .circular(20),
                ),
                child: Text(
                  badge,
                  style: AppText().semiBold14(
                    context,
                    AppConstants().neonBlue,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 4),

        Text(description, style: AppText().caption(context)),
      ],
    );
  }
}
