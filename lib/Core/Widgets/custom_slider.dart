import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    super.key,
    required this.initialValue,
    required this.min,
    required this.max,
    required this.divisions,
    this.onChanged,
    this.enable = true,
  });

  final double initialValue;
  final double min;
  final double max;
  final int divisions;
  final bool enable;
  final void Function(double value)? onChanged;

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double value;

  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slider.adaptive(
      value: value,
      min: widget.min,
      divisions: widget.divisions,
      max: widget.max,
      onChanged: widget.enable
          ? (value) {
              setState(() {
                this.value = value;
              });
              widget.onChanged?.call(value);
            }
          : null,
      activeColor: AppConstants().neonBlue,
      showValueIndicator: .onDrag,
      label: '${value.round()}',
    );
  }
}
