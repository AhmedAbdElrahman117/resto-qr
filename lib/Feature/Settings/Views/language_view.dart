import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Cubit/app_cubit.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/assets.dart';
import 'package:resto_qr/Core/Widgets/sliver_sized_box.dart';
import 'package:resto_qr/Feature/Settings/Models/language_model.dart';
import 'package:resto_qr/Feature/Settings/Widgets/language_option_tile.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  static const List<LanguageModel> _languages = [
    LanguageModel(name: 'English', code: 'en', flag: Assets.flagsUS),
    LanguageModel(name: 'Arabic', code: 'ar', flag: Assets.flagsEgypt),
    LanguageModel(name: 'German', code: 'de', flag: Assets.flagsGermany),
    LanguageModel(name: 'French', code: 'fr', flag: Assets.flagsFrance),
    LanguageModel(name: 'Spanish', code: 'es', flag: Assets.flagsSpain),
    LanguageModel(name: 'Chinese', code: 'zh', flag: Assets.flagsChina),
    LanguageModel(name: 'Japanese', code: 'ja', flag: Assets.flagsJapan),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    final currentLanguage = context.select<AppCubit, String>(
      (cubit) => cubit.state.languageCode,
    );

    return Scaffold(
      body: RadioGroup<String>(
        onChanged: (value) {
          context.read<AppCubit>().changeLanguage(
            languageCode: value!,
            languageName: _languages.firstWhere((e) => e.code == value).name,
          );
        },
        groupValue: currentLanguage,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              title: Text(l10n.language),
              centerTitle: true,
              floating: true,
              snap: true,
            ),

            SliverPadding(
              padding: const .symmetric(horizontal: 16),
              sliver: SliverMainAxisGroup(
                slivers: [
                  const SliverSizedBox(height: 16),

                  SliverToBoxAdapter(
                    child: Text(
                      AppLocalization.of(context).preferedLanguage,
                      style: AppText().semiBold18(context),
                    ),
                  ),

                  const SliverSizedBox(height: 4),

                  SliverToBoxAdapter(
                    child: Text(
                      AppLocalization.of(context).preferedLanguageDescription,
                      style: AppText().caption(context),
                    ),
                  ),

                  const SliverSizedBox(height: 16),

                  SliverList.separated(
                    itemCount: _languages.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) => LanguageOptionTile(
                      language: _languages[index],
                      groupValue: currentLanguage,
                    ),
                  ),

                  const SliverSizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
