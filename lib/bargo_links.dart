import 'package:flutter/material.dart';
import 'package:rubargo_ui_kit/rubargo_ui_kit.dart';
import 'package:rubargo_ui_kit/util/default_bargo_style.dart';
import 'package:rubargo_ui_kit/util/stateful_button.dart';

enum _ELinkSize {
  big,
  medium,
  small,
}

class BargoLink extends StatelessWidget {
  const BargoLink.big(
    this.text, {
    Key? key,
    this.icon,
  })  : _linkSize = _ELinkSize.big,
        super(key: key);

  const BargoLink.medium(
    this.text, {
    Key? key,
    this.icon,
  })  : _linkSize = _ELinkSize.medium,
        super(key: key);

  const BargoLink.small(
    this.text, {
    Key? key,
    this.icon,
  })  : _linkSize = _ELinkSize.small,
        super(key: key);

  final String text;
  final Widget? icon;
  final _ELinkSize _linkSize;

  BargoTextStyle _getTextStyle() {
    switch (_linkSize) {
      case _ELinkSize.big:
        return BargoTextStyle.h4Heading;
      case _ELinkSize.medium:
        return BargoTextStyle.h5Heading;
      case _ELinkSize.small:
        return BargoTextStyle.h6Text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulButton(
      builder: (context) {
        final buttonState = ButtonState.of(context);

        final row = Builder(
          builder: (context) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              BargoText(text),
              if (icon != null) ...[
                const SizedBox(width: 10),
                icon!,
              ]
            ],
          ),
        );

        return buttonState.when(
          active: () => IconTheme(
            data: const IconThemeData(color: BargoColor.link),
            child: DefaultTextStyle(
              style: const TextStyle(color: BargoColor.link),
              child: DefaultBargoTextStyle(
                style: _getTextStyle(),
                child: row,
              ),
            ),
          ),
          hover: () => IconTheme(
            data: const IconThemeData(color: BargoColor.placeholder),
            child: DefaultTextStyle(
              style: const TextStyle(color: BargoColor.placeholder),
              child: DefaultBargoTextStyle(
                style: _getTextStyle(),
                child: row,
              ),
            ),
          ),
          pressed: () => IconTheme(
            data: const IconThemeData(color: BargoColor.press),
            child: DefaultTextStyle(
              style: const TextStyle(color: BargoColor.press),
              child: DefaultBargoTextStyle(
                style: _getTextStyle(),
                child: row,
              ),
            ),
          ),
          disabled: () => IconTheme(
            data: const IconThemeData(color: BargoColor.disable),
            child: DefaultTextStyle(
              style: const TextStyle(color: BargoColor.disable),
              child: DefaultBargoTextStyle(
                style: _getTextStyle(),
                child: row,
              ),
            ),
          ),
        );
      },
    );
  }
}