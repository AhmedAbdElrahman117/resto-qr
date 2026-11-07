import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Feature/Maps/Model/place_model.dart';

class LocationDetails extends StatelessWidget {
  const LocationDetails({super.key, required this.place, this.onSelect});

  final PlaceModel place;
  final void Function()? onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          place.name,
          style: AppText().bold24(context),
        ),
        const SizedBox(height: 12),
        Text(
          place.address,
          style: AppText().regular18(context),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: onSelect,
          label: Text(
            'Select',
            style: AppText().regular16(context),
          ),
          icon: Icon(
            Icons.check,
            color: AppTheme().primaryText(context),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants().neonBlue,
          ),
        ),
      ],
    );
  }
}
