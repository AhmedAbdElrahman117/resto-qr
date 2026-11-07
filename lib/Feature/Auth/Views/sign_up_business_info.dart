import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Widgets/custom_text_field.dart';
import 'package:resto_qr/Feature/Auth/Helper/business_info_helper.dart';
import 'package:resto_qr/Feature/Auth/Widgets/pick_image_button.dart';
import 'package:resto_qr/Feature/Maps/Model/place_model.dart';
import 'package:resto_qr/Feature/Maps/View%20Model/map_cubit.dart';
import 'package:resto_qr/Feature/Maps/map_view.dart';

class SignUpBusinessInfo extends StatelessWidget {
  const SignUpBusinessInfo({
    super.key,
    required this.businessInfoHelper,
  });

  final BusinessInfoHelper businessInfoHelper;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalization.of(context);
    return Form(
      key: businessInfoHelper.businessInfo,
      child: SingleChildScrollView(
        padding: const .fromLTRB(20, 24, 20, 40),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              l10n.businessInfo,
              style: AppText().bold24(context),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.addRestaurantDetails,
              style: AppText().regular14(context),
            ),
            const SizedBox(height: 24),
            PickImageButton(
              title: l10n.uploadRestaurantLogo,
              onImageSelected: (imagePath) {
                businessInfoHelper.image = imagePath;
              },
            ),
            const SizedBox(height: 24),
            nameTextField(),
            const SizedBox(height: 16),
            locationTextField(context),
            const SizedBox(height: 16),
            addressTextField(),
            const SizedBox(height: 16),
            descriptionTextField(),
          ],
        ),
      ),
    );
  }

  Widget descriptionTextField() {
    final l10n = AppLocalization.current;
    return CustomTextField(
      controller: businessInfoHelper.descriptionController,
      labelText: l10n.descriptionOptional,
      hintText: l10n.addRestaurantDescription,
      focusNode: businessInfoHelper.descriptionFocus,
      maxLines: 6,
      validator: (_) => null,
    );
  }

  CustomTextField addressTextField() {
    final l10n = AppLocalization.current;
    return CustomTextField(
      controller: businessInfoHelper.addressController,
      prefixIcon: Icons.map,
      labelText: l10n.restaurantAddress,
      hintText: l10n.enterRestaurantAddress,
      focusNode: businessInfoHelper.addressFocus,
      nextFocus: businessInfoHelper.descriptionFocus,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return l10n.restaurantAddressRequired;
        }
        return null;
      },
    );
  }

  CustomTextField locationTextField(
    BuildContext context,
  ) {
    final l10n = AppLocalization.of(context);
    return CustomTextField(
      controller: businessInfoHelper.locationController,
      prefixIcon: Icons.location_pin,
      labelText: l10n.restaurantLocation,
      hintText: l10n.selectRestaurantLocation,
      enabled: false,
      onTap: () async {
        var res =
            await Navigation().push(
                  context,
                  BlocProvider(
                    create: (context) => MapCubit()
                      ..initMap(
                        onDisableGPS: (location) {},
                        onDeny: (location) {},
                        onPermanentlyDenied: (location) {},
                      ),
                    child: MapView(),
                  ),
                )
                as PlaceModel?;

        if (res != null) {
          businessInfoHelper.selectedPlace = res;

          businessInfoHelper.locationController.text = '${res.lat}, ${res.lng}';

          businessInfoHelper.addressController.text = res.address;
        }
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return l10n.restaurantLocationRequired;
        }
        return null;
      },
    );
  }

  CustomTextField nameTextField() {
    final l10n = AppLocalization.current;
    return CustomTextField(
      controller: businessInfoHelper.nameController,
      prefixIcon: Icons.local_restaurant,
      labelText: l10n.restaurantName,
      hintText: l10n.enterRestaurantName,
      focusNode: businessInfoHelper.nameFocus,
      nextFocus: businessInfoHelper.addressFocus,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return l10n.restaurantNameRequired;
        }
        return null;
      },
    );
  }
}
