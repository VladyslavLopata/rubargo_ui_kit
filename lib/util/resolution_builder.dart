import 'package:flutter/material.dart';

class ResolutionBuilder extends StatelessWidget {
  const ResolutionBuilder({
    Key? key,
    required this.mobile,
    required this.desktop,
  }) : super(key: key);

  final Widget Function(BuildContext context) mobile;
  final Widget Function(BuildContext context) desktop;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width > 900) {
      return desktop(context);
    }
    return mobile(context);
  }
}
