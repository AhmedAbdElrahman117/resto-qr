import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';

class MyLocationButton extends StatelessWidget {
  const MyLocationButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppConstants().neonBlue,
      shape: const CircleBorder(),
      tooltip: 'Current Location',
      child: const Icon(Icons.my_location),
    );
  }
}
