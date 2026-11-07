import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/assets.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Utils/toast.dart';
import 'package:resto_qr/Core/Widgets/bloc_widget.dart';
import 'package:resto_qr/Core/Widgets/counter_widget.dart';
import 'package:resto_qr/Core/Widgets/empty_state_widget.dart';
import 'package:resto_qr/Core/Widgets/sliver_sized_box.dart';
import 'package:resto_qr/Feature/Menu/Models/offer_model.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Offer%20Cubit/offer_cubit.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Offer%20Cubit/offer_states.dart';
import 'package:resto_qr/Feature/Menu/Views/add_offer_view.dart';
import 'package:resto_qr/Feature/Menu/Widgets/offer_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OffersView extends StatelessWidget {
  const OffersView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(l10n.offers),
            centerTitle: true,
            floating: true,
            snap: true,
          ),

          const SliverSizedBox(height: 16),

          SliverPadding(
            padding: const .symmetric(horizontal: 16),
            sliver: SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Text(
                        l10n.offers,
                        style: AppText().semiBold18(context),
                      ),

                      const Spacer(),

                      BlocWidget<OfferCubit, OfferStates>(
                        listener: _listener,
                        buildWhen: (prev, curr) =>
                            curr is OffersError ||
                            curr is OffersEmpty ||
                            curr is OffersLoading ||
                            curr is OffersLoaded,
                        builder: (context, state) => Skeletonizer(
                          enabled: state is OffersLoading,
                          enableSwitchAnimation: true,
                          child: CounterWidget(
                            count: state is OffersLoaded
                                ? state.offers.length
                                : 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SliverSizedBox(height: 6),

                SliverToBoxAdapter(
                  child: Text(
                    l10n.offerInstructions,
                    style: AppText().caption(context),
                  ),
                ),

                const SliverSizedBox(height: 16),

                BlocWidget<OfferCubit, OfferStates>(
                  buildWhen: (prev, curr) =>
                      curr is OffersError ||
                      curr is OffersEmpty ||
                      curr is OffersLoading ||
                      curr is OffersLoaded,
                  builder: (context, state) {
                    if (state is OffersEmpty) {
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: EmptyStateWidget(
                          title: l10n.noOffersYet,
                          message: l10n.addOffersDescription,
                        ),
                      );
                    } else if (state is OffersError) {
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: EmptyStateWidget(
                          title: l10n.error,
                          message: state.errorMessage,
                          image: Assets.imagesError,
                        ),
                      );
                    }
                    var data = state is OffersLoaded
                        ? state.offers
                        : List.generate(3, (index) => EmptyOfferModel());

                    return Skeletonizer.sliver(
                      enabled: state is OffersLoading,
                      child: SliverList.separated(
                        itemCount: data.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemBuilder: (context, index) =>
                            OfferCard(offer: data[index]),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SliverSizedBox(height: 32),
        ],
      ),

      floatingActionButton: addItemButton(context),
    );
  }

  void _listener(BuildContext context, OfferStates state) {
    if (state is OffersError) {
      Toast().showError(
        title: AppLocalization.of(context).error,
        description: state.errorMessage,
      );
    } else if (state is OfferItemsError) {
      Toast().showError(
        title: AppLocalization.of(context).error,
        description: state.errorMessage,
      );
    } else if (state is OfferAddError) {
      Toast().showError(
        title: AppLocalization.of(context).error,
        description: state.errorMessage,
      );
    } else if (state is OfferUpdateError) {
      Toast().showError(
        title: AppLocalization.of(context).error,
        description: state.errorMessage,
      );
    } else if (state is OfferDeleteError) {
      Toast().showError(
        title: AppLocalization.of(context).error,
        description: state.errorMessage,
      );
    } else if (state is OfferToggleError) {
      Toast().showError(
        title: AppLocalization.of(context).error,
        description: state.errorMessage,
      );
    } else if (state is OfferDeleted) {
      Toast().showSuccess(
        title: AppLocalization.of(context).success,
        description: AppLocalization.of(context).offerDeletedDescription,
      );
    } else if (state is OfferAdded) {
      Toast().showSuccess(
        title: AppLocalization.of(context).success,
        description: AppLocalization.of(context).offerAddedDescription,
      );
    } else if (state is OfferUpdated) {
      Toast().showSuccess(
        title: AppLocalization.of(context).success,
        description: AppLocalization.of(context).offerUpdatedDescription,
      );
    } else if (state is OfferDeleted) {
      Toast().showSuccess(
        title: AppLocalization.of(context).success,
        description: AppLocalization.of(context).offerDeletedDescription,
      );
    } else if (state is OfferToggled) {
      Toast().showSuccess(
        title: AppLocalization.of(context).success,
        description: state.isActive
            ? AppLocalization.of(context).offerActivatedDescription
            : AppLocalization.of(context).offerDeactivatedDescription,
      );
    }
  }

  Widget addItemButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigation().push(
          context,
          BlocProvider.value(
            value: context.read<OfferCubit>(),
            child: const AddOfferView(),
          ),
        );
      },
      backgroundColor: AppConstants().neonBlue,
      shape: const CircleBorder(),
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
