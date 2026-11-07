import 'package:flutter/material.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';

class CustomSwitchTile extends StatefulWidget {
  const CustomSwitchTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.color,
    this.initialValue = true,
    this.onToggle,
    this.backgroundColor,
    this.secondry,
    this.border,
    this.radius,
    this.showIcon = true,
    this.contentPadding,
  });

  final String title;
  final String? subtitle;
  final Color color;
  final bool initialValue;
  final void Function(bool value)? onToggle;
  final Color? backgroundColor;
  final Widget? secondry;
  final BorderSide? border;
  final double? radius;
  final bool showIcon;
  final EdgeInsetsGeometry? contentPadding;

  @override
  State<CustomSwitchTile> createState() => _CustomSwitchTileState();
}

class _CustomSwitchTileState extends State<CustomSwitchTile> {
  late bool isToggled;

  @override
  void initState() {
    isToggled = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: isToggled,
      tileColor: widget.backgroundColor,
      onChanged: widget.onToggle == null
          ? null
          : (value) {
              setState(() {
                isToggled = value;
              });
              widget.onToggle?.call(value);
            },
      activeThumbColor: widget.color,
      activeTrackColor: widget.color.withValues(alpha: 0.4),
      shape: RoundedRectangleBorder(
        borderRadius: .circular(widget.radius ?? 12),
        side: widget.border ?? .none,
      ),
      secondary: (widget.showIcon && widget.secondry == null)
          ? Icon(Icons.visibility, color: widget.color)
          : widget.secondry,
      title: Text(widget.title, style: AppText().bold16(context)),
      contentPadding: widget.contentPadding,
      subtitle: widget.subtitle != null
          ? Text(
              widget.subtitle!,
              style: AppText().caption(context),
            )
          : null,
    );
  }
}
