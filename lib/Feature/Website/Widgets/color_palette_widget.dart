import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Widgets/custom_container.dart';

class ColorPaletteWidget extends StatelessWidget {
  const ColorPaletteWidget({
    super.key,
    required this.primaryColor,
  });

  final ValueNotifier<Color> primaryColor;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: .all(20),
      child: Center(
        child: ColorPicker(
          pickerColor: primaryColor.value,
          hexInputBar: true,
          enableAlpha: false,
          displayThumbColor: true,
          paletteType: .hueWheel,
          pickerAreaBorderRadius: .circular(12),
          pickerAreaHeightPercent: 0.8,
          labelTypes: [
            ColorLabelType.rgb,
            ColorLabelType.hex,
          ],
          // ignore: deprecated_member_use
          labelTextStyle: AppText().semiBold18(context),
          onColorChanged: (color) {
            primaryColor.value = color;
          },
        ),
      ),
    );
  }
}
