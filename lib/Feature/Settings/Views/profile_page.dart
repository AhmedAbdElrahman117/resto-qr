import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Models/user_model.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Widgets/sliver_sized_box.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Login%20Cubit/login_cubit.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Login%20Cubit/login_state.dart';
import 'package:resto_qr/Feature/Settings/Widgets/account_setting_options.dart';
import 'package:resto_qr/Feature/Settings/Widgets/logout_button.dart';
import 'package:resto_qr/Feature/Settings/Widgets/profile_info.dart';
import 'package:resto_qr/Feature/Settings/Widgets/version_number.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: Text(l10n.profile),
            centerTitle: true,
            floating: true,
            snap: true,
          ),

          const SliverSizedBox(height: 16),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: BlocSelector<LoginCubit, LoginState, UserModel?>(
                    selector: (state) {
                      return state is LoginSuccess ? state.user : null;
                    },
                    builder: (context, state) {
                      return ProfileInfo(info: state ?? EmptyUser());
                    },
                  ),
                ),

                const SliverSizedBox(height: 32),

                SliverToBoxAdapter(
                  child: Text(
                    l10n.accountSettings,
                    style: AppText().semiBold16(context),
                  ),
                ),

                const SliverSizedBox(height: 4),

                SliverToBoxAdapter(
                  child: Text(
                    l10n.accountSettingsDescription,
                    style: AppText().caption(context),
                  ),
                ),

                const SliverSizedBox(height: 16),

                const AccountSettingOptions(),

                const SliverSizedBox(height: 40),

                const SliverToBoxAdapter(child: LogoutButton()),

                const SliverSizedBox(height: 24),

                const SliverToBoxAdapter(child: VersionNumber()),

                const SliverSizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
