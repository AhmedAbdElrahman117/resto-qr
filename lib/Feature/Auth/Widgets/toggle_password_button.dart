import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TogglePasswordButton extends StatelessWidget {
  const TogglePasswordButton({
    super.key,
    required this.showPassword,
    this.onPressed,
  });

  final void Function()? onPressed;
  final bool showPassword;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: animatedIcon(),
    );
  }

  Widget animatedIcon() {
    return AnimatedCrossFade(
      firstChild: FaIcon(FontAwesomeIcons.eyeSlash),
      secondChild: FaIcon(FontAwesomeIcons.eye),
      crossFadeState: showPassword ? .showFirst : .showSecond,
      duration: .new(milliseconds: 350),
    );
  }
}
