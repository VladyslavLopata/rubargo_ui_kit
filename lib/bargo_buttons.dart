import 'package:flutter/material.dart';
import 'package:rubargo_ui_kit/bargo_colors.dart';
import 'package:rubargo_ui_kit/bargo_text.dart';
import 'package:rubargo_ui_kit/util/default_bargo_style.dart';
import 'package:rubargo_ui_kit/util/resolution_builder.dart';
import 'package:rubargo_ui_kit/util/stateful_button.dart';

enum EButtonType {
  primary,
  secondary,
  secondaryIcon,
  secondaryIconWhite,
  ghostWithIcon,
  ghostIcon,
  controls,
  hint,
}

/// Primary button from rubargo ui toolkit.
/// Injects corresponding text color and icon color on state change,
/// so that you don't have to manage it by yourself.
/// If you need to reuse injected color, use [Theme.of(context).iconTheme.color]
/// If [onTap] is not supplied, then button is disabled.
class BargoButton extends StatelessWidget {
  const BargoButton.primary({
    Key? key,
    required this.child,
    this.onTap,
  })  : _buttonType = EButtonType.primary,
        super(key: key);

  const BargoButton.primaryWithIcon({
    Key? key,
    required this.child,
    this.onTap,
  })  : _buttonType = EButtonType.primary,
        super(key: key);

  const BargoButton.secondary({
    Key? key,
    required this.child,
    this.onTap,
  })  : _buttonType = EButtonType.secondary,
        super(key: key);

  const BargoButton.secondaryWithIcon({
    Key? key,
    required this.child,
    this.onTap,
  })  : _buttonType = EButtonType.secondary,
        super(key: key);

  const BargoButton.secondaryIcon({
    Key? key,
    required this.child,
    this.onTap,
  })  : _buttonType = EButtonType.secondaryIcon,
        super(key: key);

  const BargoButton.secondaryIconWhite({
    Key? key,
    required this.child,
    this.onTap,
  })  : _buttonType = EButtonType.secondaryIconWhite,
        super(key: key);

  const BargoButton.ghostWithIcon({
    Key? key,
    required this.child,
    this.onTap,
  })  : _buttonType = EButtonType.ghostWithIcon,
        super(key: key);

  const BargoButton.ghostIcon({
    Key? key,
    required this.child,
    this.onTap,
  })  : _buttonType = EButtonType.ghostIcon,
        super(key: key);

  const BargoButton.controls({
    Key? key,
    required this.child,
    this.onTap,
  })  : _buttonType = EButtonType.controls,
        super(key: key);

  const BargoButton.hint({
    Key? key,
    required this.child,
    this.onTap,
  })  : _buttonType = EButtonType.hint,
        super(key: key);

  final Widget child;
  final VoidCallback? onTap;
  final EButtonType _buttonType;

  Color _childTextAndIconColor(EButtonState state) {
    if (state == EButtonState.disabled) {
      return BargoColor.placeholder;
    }

    return BargoColor.foreground;
  }

  BoxDecoration _getDecorationOutline() {
    switch (_buttonType) {
      case EButtonType.primary:
      case EButtonType.secondary:
      case EButtonType.ghostIcon:
      case EButtonType.ghostWithIcon:
      case EButtonType.controls:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        );
      case EButtonType.secondaryIcon:
      case EButtonType.secondaryIconWhite:
      case EButtonType.hint:
        return const BoxDecoration(
          shape: BoxShape.circle,
        );
    }
  }

  Color _getDecorationColor(ButtonState buttonState) {
    switch (_buttonType) {
      case EButtonType.primary:
        return buttonState.when(
          active: () => BargoColor.primary,
          hover: () => BargoColor.placeholder,
          pressed: () => BargoColor.press,
          disabled: () => BargoColor.disable,
        );
      case EButtonType.secondaryIcon:
      case EButtonType.secondaryIconWhite:
      case EButtonType.secondary:
      case EButtonType.controls:
      case EButtonType.ghostIcon:
      case EButtonType.ghostWithIcon:
        return buttonState.when(
          active: () => Colors.transparent,
          hover: () => BargoColor.placeholder,
          pressed: () => BargoColor.press,
          disabled: () => Colors.transparent,
        );
      case EButtonType.hint:
        return buttonState.when(
          active: () => BargoColor.hint,
          hover: () => BargoColor.placeholder,
          pressed: () => BargoColor.press,
          disabled: () => BargoColor.placeholder,
        );
    }
  }

  Border? _getDecodationBorder(ButtonState buttonState) {
    switch (_buttonType) {
      case EButtonType.primary:
      case EButtonType.controls:
      case EButtonType.ghostIcon:
      case EButtonType.ghostWithIcon:
      case EButtonType.hint:
        return null;
      case EButtonType.secondary:
      case EButtonType.secondaryIcon:
        return buttonState.when(
          active: () => Border.all(color: BargoColor.primary),
          hover: () => null,
          pressed: () => null,
          disabled: () => Border.all(color: BargoColor.placeholder),
        );
      case EButtonType.secondaryIconWhite:
        return buttonState.when(
          active: () => Border.all(color: BargoColor.foreground),
          hover: () => null,
          pressed: () => null,
          disabled: () => Border.all(color: BargoColor.placeholder),
        );
    }
  }

  double _getVerticalPadding() {
    switch (_buttonType) {
      case EButtonType.primary:
      case EButtonType.secondary:
      case EButtonType.secondaryIcon:
      case EButtonType.secondaryIconWhite:
      case EButtonType.ghostWithIcon:
        return 16.0;
      case EButtonType.ghostIcon:
        return 12.0;
      case EButtonType.controls:
        return 8.0;
      case EButtonType.hint:
        return 0.0;
    }
  }

  double _getHorizontalPadding() {
    switch (_buttonType) {
      case EButtonType.primary:
      case EButtonType.secondary:
      case EButtonType.ghostWithIcon:
        return 24.0;
      case EButtonType.secondaryIcon:
      case EButtonType.secondaryIconWhite:
        return 16.0;
      case EButtonType.ghostIcon:
        return 12.0;
      case EButtonType.controls:
        return 8.0;
      case EButtonType.hint:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulButton(
      onTap: onTap,
      builder: (context) {
        final buttonState = ButtonState.of(context);

        final decorationOutline = _getDecorationOutline();

        final defaultTextStyle = DefaultTextStyle.of(context);

        final innerWidgetColor = _childTextAndIconColor(
          buttonState.state,
        );

        return Container(
          padding: EdgeInsets.symmetric(
            vertical: _getVerticalPadding(),
            horizontal: _getHorizontalPadding(),
          ),
          decoration: decorationOutline.copyWith(
            color: _getDecorationColor(buttonState),
            border: _getDecodationBorder(buttonState),
          ),
          child: IconTheme(
            data: Theme.of(context).iconTheme.copyWith(
                  color: innerWidgetColor,
                ),
            child: DefaultTextStyle(
              style: defaultTextStyle.style.merge(
                TextStyle(color: innerWidgetColor),
              ),
              child: ResolutionBuilder(
                mobile: (context) => DefaultBargoTextStyle(
                  style: BargoTextStyle.h4Heading,
                  child: child,
                ),
                desktop: (context) => DefaultBargoTextStyle(
                  style: BargoTextStyle.h5Heading,
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
