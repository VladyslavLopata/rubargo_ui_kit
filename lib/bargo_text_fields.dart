import 'package:flutter/material.dart';
import 'package:rubargo_ui_kit/bargo_colors.dart';
import 'package:rubargo_ui_kit/util/custom_ink_well.dart';

enum EFieldState {
  active,
  hover,
  pressed,
  selected,
}

class RuBargoInputField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final void Function(String text)? onTextChanged;
  final bool multiLine;
  const RuBargoInputField({
    Key? key,
    this.hintText,
    this.controller,
    this.onTextChanged,
    this.multiLine = false,
  }) : super(key: key);

  @override
  State<RuBargoInputField> createState() => _RuBargoInputFieldState();
}

class _RuBargoInputFieldState extends State<RuBargoInputField> {
  final FocusNode _focusNode = FocusNode();

  EFieldState _fieldState = EFieldState.active;

  bool hasFocus = false;
  bool _hover = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_nodeListener);
  }

  void _nodeListener() {
    setState(() {
      hasFocus = _focusNode.hasFocus;
    });
  }

  void onHover(bool hover) {
    _hover = hover;

    setState(() {
      _fieldState = EFieldState.hover;
    });
  }

  void onPress() {
    _focusNode.requestFocus();
  }

  void onTapDown() {
    setState(() {
      _fieldState = EFieldState.pressed;
    });
  }

  void onTapCancel() {
    setState(() {
      _fieldState = EFieldState.pressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);

    return CustomInkWell(
      onTap: onPress,
      onTapDown: onTapDown,
      onTapCancel: onTapCancel,
      child: CustomDecoration(
        state: EFieldState.active,
        child: TextField(
          controller: widget.controller,
          onChanged: widget.onTextChanged,
          focusNode: _focusNode,
          style: defaultTextStyle.style.copyWith(
            color: hasFocus ? BargoColor.foreground : null,
          ),
          cursorColor: BargoColor.foreground,
          cursorHeight: 24,
          maxLines: widget.multiLine ? 6 : 1,
          minLines: widget.multiLine ? 6 : 1,
          decoration: InputDecoration(
            border: InputBorder.none,
            isDense: true,
            isCollapsed: true,
            hintText: hasFocus ? null : widget.hintText,
            hintStyle: defaultTextStyle.style.copyWith(
              color: BargoColor.placeholder,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDecoration extends StatelessWidget {
  final Widget child;
  final EFieldState state;
  const CustomDecoration({
    Key? key,
    required this.child,
    required this.state,
  }) : super(key: key);

  Color _getFieldColor() {
    switch (state) {
      case EFieldState.active:
        return Colors.transparent;
      case EFieldState.hover:
        return BargoColor.placeholder;
      case EFieldState.pressed:
        return BargoColor.press;
      case EFieldState.selected:
        return BargoColor.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: state == EFieldState.active
            ? null
            : Border.all(
                color: BargoColor.primary,
                width: 2,
              ),
        borderRadius: BorderRadius.circular(8),
        color: _getFieldColor(),
      ),
      child: child,
    );
  }
}
