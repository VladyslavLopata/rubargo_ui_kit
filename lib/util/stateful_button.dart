import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rubargo_ui_kit/util/custom_ink_well.dart';

class ButtonState extends InheritedWidget {
  final EButtonState state;

  const ButtonState({
    Key? key,
    required this.state,
    required Widget child,
  }) : super(child: child, key: key);

  T when<T>({
    required T Function() active,
    required T Function() hover,
    required T Function() pressed,
    required T Function() disabled,
  }) {
    switch (state) {
      case EButtonState.active:
        return active();
      case EButtonState.hover:
        return hover();
      case EButtonState.pressed:
        return pressed();
      case EButtonState.disabled:
        return disabled();
    }
  }

  static ButtonState of(BuildContext context) {
    final ButtonState? result =
        context.dependOnInheritedWidgetOfExactType<ButtonState>();
    assert(result != null, 'No ButtonState found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ButtonState oldWidget) => state != oldWidget.state;
}

enum EButtonState {
  active,
  hover,
  pressed,
  disabled,
}

class StatefulButton extends StatefulWidget {
  const StatefulButton({
    Key? key,
    this.onTap,
    required this.builder,
  }) : super(key: key);

  final Widget Function(BuildContext context) builder;
  final VoidCallback? onTap;

  @override
  State<StatefulButton> createState() => _StatefulButtonState();
}

class _StatefulButtonState extends State<StatefulButton> {
  final _buttonStateStream = StreamController<EButtonState>();
  bool _enabled = false;

  // This one doesn't need to be setState'd, because it is only used to control
  // flow of events in the button state stream.
  var _hover = false;

  @override
  void initState() {
    super.initState();
    _enabled = widget.onTap != null;
  }

  @override
  void dispose() {
    _buttonStateStream.close();
    super.dispose();
  }

  void onHover(bool hover) {
    _hover = hover;
    _buttonStateStream.add(
      hover ? EButtonState.hover : EButtonState.active,
    );
  }

  void onPress() {
    _buttonStateStream.add(EButtonState.pressed);
  }

  void released() {
    _buttonStateStream.add(_hover ? EButtonState.hover : EButtonState.active);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EButtonState>(
      stream: _buttonStateStream.stream.where((_) => _enabled),
      initialData: _enabled ? EButtonState.active : EButtonState.disabled,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }

        final buttonState = snapshot.data;

        final Widget innerWidget;

        final innerBuilder = Builder(
          builder: widget.builder,
        );

        if (_enabled) {
          innerWidget = CustomInkWell(
            onTap: buttonState != EButtonState.disabled ? widget.onTap : null,
            onHover: onHover,
            child: innerBuilder,
          );
        } else {
          innerWidget = innerBuilder;
        }

        return ButtonState(
          state: buttonState!,
          child: innerWidget,
        );
      },
    );
  }
}
