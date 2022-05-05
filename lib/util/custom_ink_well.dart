import 'package:flutter/material.dart';

typedef BoolCallback = void Function(bool state);

class CustomInkWell extends StatelessWidget {
  const CustomInkWell({
    Key? key,
    this.onTap,
    this.onTapDown,
    this.onTapCancel,
    this.onHover,
    this.child,
  }) : super(key: key);

  final VoidCallback? onTap;
  final VoidCallback? onTapDown;
  final VoidCallback? onTapCancel;
  final BoolCallback? onHover;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onHover: onHover,
      onTapDown: (_) => onTapDown,
      canRequestFocus: false,
      onLongPress: onTap,
      onTapCancel: onTapCancel,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: child,
    );
  }
}
