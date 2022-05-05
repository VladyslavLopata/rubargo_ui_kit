import 'package:flutter/material.dart';
import 'package:rubargo_ui_kit/bargo_text.dart';

class DefaultBargoTextStyle extends InheritedWidget {
  const DefaultBargoTextStyle({
    Key? key,
    required this.style,
    required Widget child,
  }) : super(key: key, child: child);

  final BargoTextStyle style;

  static DefaultBargoTextStyle? of(BuildContext context) {
    final DefaultBargoTextStyle? result =
        context.dependOnInheritedWidgetOfExactType<DefaultBargoTextStyle>();
    return result;
  }

  @override
  bool updateShouldNotify(DefaultBargoTextStyle oldWidget) =>
      style != oldWidget.style;
}
