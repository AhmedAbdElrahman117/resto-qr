import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.waveDots(
      color: AppConstants().neonBlue,
      size: getSize(context),
    );
  }

  double getSize(BuildContext context) {
    var indicatorSize = MediaQuery.of(context).size.width * 0.12;

    return indicatorSize > 40 ? indicatorSize : 40;
  }
}
