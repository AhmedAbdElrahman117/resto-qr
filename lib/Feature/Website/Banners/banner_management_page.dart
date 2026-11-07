import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_dialogs.dart';
import 'package:resto_qr/Core/Utils/assets.dart';
import 'package:resto_qr/Core/Utils/toast.dart';
import 'package:resto_qr/Core/Widgets/bloc_widget.dart';
import 'package:resto_qr/Core/Widgets/empty_state_widget.dart';
import 'package:resto_qr/Core/Widgets/loading_widget.dart';
import 'package:resto_qr/Feature/Auth/View%20Model/Login%20Cubit/login_cubit.dart';
import 'package:resto_qr/Feature/Website/Banners/Models/banner_model.dart';
import 'package:resto_qr/Feature/Website/Banners/View%20Model/banner_cubit.dart';
import 'package:resto_qr/Feature/Website/Banners/View%20Model/banner_state.dart';
import 'package:resto_qr/Feature/Website/Banners/Widgets/add_banner_dialog.dart';
import 'package:resto_qr/Feature/Website/Banners/Widgets/banner_list_card.dart';
import 'package:resto_qr/Feature/Website/Banners/Widgets/completed_banner_card.dart';

class BannerManagementPage extends StatelessWidget {
  const BannerManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.promotionalBanners),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: AppConstants().neonBlue,
            labelColor: AppConstants().neonBlue,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: l10n.active),
              Tab(text: l10n.completed),
            ],
          ),
        ),
        body: BlocWidget<BannerCubit, BannerState>(
          isSliver: false,
          listener: _listener,
          buildWhen: (prev, curr) =>
              curr is! BannerToggleSuccess &&
              curr is! BannerItemsLoadingState &&
              curr is! BannerItemsLoadedState &&
              curr is! BannerDialogLoadingState &&
              curr is! BannerUpdatedSuccess &&
              curr is! BannerAddedSuccess &&
              curr is! BannerDeleteLoadingState &&
              curr is! BannerDeletedSuccess,

          builder: (context, state) {
            if (state is BannerErrorState) {
              return Center(
                child: Text(l10n.errorLoadingBanners),
              );
            } else if (state is BannerLoadingState) {
              return const Center(
                child: LoadingWidget(),
              );
            } else if (state is BannerEmptyState) {
              return Center(
                child: EmptyStateWidget(
                  title: l10n.noBanners,
                  message: l10n.noBannersDescription,
                  image: Assets.imagesPromotionSpeaker,
                ),
              );
            }

            final activeBanners = (state as BannerLoadedState).activeBanners;

            final completedBanners = (state).completedBanners;

            return TabBarView(
              children: [
                _buildBannerList(
                  context: context,
                  banners: activeBanners,
                  emptyTitle: l10n.noActiveBannersTitle,
                  emptyMessage: l10n.noActiveBannersDescription,
                  isActive: true,
                ),

                _buildBannerList(
                  context: context,
                  banners: completedBanners,
                  emptyTitle: l10n.noCompletedBanners,
                  emptyMessage: l10n.noCompletedBannersDescription,
                  isActive: false,
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AppDialogs().showDialog(
              context: context,
              child: AddBannerDialog(
                cubit: context.read<BannerCubit>(),
                menuId: context.read<LoginCubit>().state.user.menuId!,
                ownerId: context.read<LoginCubit>().state.user.id!,
              ),
            );
          },
          backgroundColor: AppConstants().neonBlue,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  void _listener(BuildContext context, state) {
    if (state is BannerAddedSuccess) {
      Toast().showSuccess(
        title: AppLocalization.of(context).bannerAdded,
        description: AppLocalization.of(context).bannerAddedDescription,
      );
    } else if (state is BannerUpdatedSuccess) {
      Toast().showSuccess(
        title: AppLocalization.of(context).bannerUpdated,
        description: AppLocalization.of(context).bannerUpdatedDescription,
      );
    } else if (state is BannerDeletedSuccess) {
      Toast().showSuccess(
        title: AppLocalization.of(context).bannerDeleted,
        description: AppLocalization.of(context).bannerDeletedDescription,
      );
    } else if (state is BannerToggleSuccess) {
      Toast().showSuccess(
        title: AppLocalization.of(context).bannerToggled,
        description: AppLocalization.of(context).bannerToggledDescription,
      );
    } else if (state is BannerErrorState) {
      Toast().showError(
        title: AppLocalization.of(context).error,
        description: state.message,
      );
    }
  }

  Widget _buildBannerList({
    required BuildContext context,
    required List<BannerModel> banners,
    required String emptyTitle,
    required String emptyMessage,
    required bool isActive,
  }) {
    if (banners.isEmpty) {
      return Center(
        child: EmptyStateWidget(
          title: emptyTitle,
          message: emptyMessage,
          image: Assets.imagesPromotionSpeaker,
        ),
      );
    }
    return ListView.separated(
      padding: const .all(16),
      physics: const BouncingScrollPhysics(),
      itemCount: banners.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        if (isActive) {
          return BannerListCard(banner: banners[index]);
        } else {
          return CompletedBannerCard(banner: banners[index]);
        }
      },
    );
  }
}
