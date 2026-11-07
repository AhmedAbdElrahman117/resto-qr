import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Dialogs/general_dialog.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_dialogs.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Widgets/bloc_widget.dart';
import 'package:resto_qr/Core/Widgets/custom_dialog.dart';
import 'package:resto_qr/Core/Widgets/custom_switch_tile.dart';
import 'package:resto_qr/Feature/Menu/Models/offer_model.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Offer%20Cubit/offer_cubit.dart';
import 'package:resto_qr/Feature/Menu/View%20Model/Offer%20Cubit/offer_states.dart';
import 'package:resto_qr/Feature/Menu/Views/add_offer_view.dart';

class OfferControlMenu extends StatelessWidget {
  const OfferControlMenu({super.key, required this.offer});

  final OfferModel offer;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return CustomDialog(
      padding: .zero,
      child: Column(
        mainAxisSize: .min,
        children: [
          header(context),

          const Divider(height: 1),

          BlocWidget<OfferCubit, OfferStates>(
            buildWhen: (prev, curr) =>
                curr is OfferToggleLoading || curr is OfferToggled,
            listener: (context, state) {
              if (state is OfferToggled) {
                offer.isVisible = state.isActive;
              }
            },
            builder: (context, state) {
              return CustomSwitchTile(
                initialValue: offer.isVisible,
                title: l10n.itemVisibleToCustomers,
                color: AppConstants().neonBlue,
                secondry: state is OfferToggleLoading
                    ? CircularProgressIndicator.adaptive(
                        backgroundColor: AppConstants().neonBlue,
                      )
                    : const Icon(Icons.visibility_outlined),
                contentPadding: const .symmetric(horizontal: 24, vertical: 8),
                radius: 0,
                onToggle: state is OfferToggleLoading
                    ? null
                    : (newValue) {
                        context.read<OfferCubit>().toggleAvailability(
                          offer: offer,
                          isVisible: newValue,
                        );
                      },
              );
            },
          ),

          const Divider(height: 1),

          optionTile(
            context: context,
            icon: Icons.edit_outlined,
            title: l10n.editOfferTitle,
            onTap: () {
              Navigation().push(
                context,
                BlocProvider.value(
                  value: context.read<OfferCubit>(),
                  child: AddOfferView(currentOffer: offer),
                ),
              );
            },
          ),

          const Divider(height: 1),

          BlocWidget<OfferCubit, OfferStates>(
            listener: (context, state) {
              if (state is OfferDeleted) {
                Navigation().pop(context);
              }
            },
            buildWhen: (prev, curr) =>
                curr is OfferDeleteLoading || curr is OfferDeleted,
            builder: (context, state) {
              return optionTile(
                context: context,
                icon: Icons.delete_outline,
                title: l10n.deleteOfferConfirmationTitle,
                color: AppConstants().errorRed,
                borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: .circular(12),
                  bottomStart: .circular(12),
                ),
                isLoading: state is OfferDeleteLoading,
                onTap: () {
                  AppDialogs().showDialog(
                    context: context,
                    child: GeneralDialog(
                      title: l10n.deleteOfferConfirmationTitle,
                      message: l10n.deleteOfferConfirmation,
                      onConfirm: (dialogContext) {
                        Navigation().pop(dialogContext);
                        context.read<OfferCubit>().deleteOffer(offer: offer);
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget optionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    Color? color,
    BorderRadiusGeometry? borderRadius,
    void Function()? onTap,
    bool isLoading = false,
  }) {
    return ListTile(
      contentPadding: const .symmetric(horizontal: 24, vertical: 8),
      leading: isLoading
          ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 2.5,
                backgroundColor: color ?? AppConstants().neonBlue,
              ),
            )
          : Icon(icon, color: color),
      title: Text(
        title,
        style: AppText().bold16(context).copyWith(color: color),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.zero,
      ),
      onTap: isLoading ? null : onTap,
    );
  }

  Widget header(BuildContext context) {
    return Padding(
      padding: const .fromLTRB(24, 20, 16, 16),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(
            AppLocalization.of(context).manageOffer,
            style: AppText().semiBold20(context),
          ),
          BlocWidget<OfferCubit, OfferStates>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.close),
                onPressed:
                    state is OfferToggleLoading || state is OfferDeleteLoading
                    ? null
                    : () => Navigator.pop(context),
              );
            },
          ),
        ],
      ),
    );
  }
}
