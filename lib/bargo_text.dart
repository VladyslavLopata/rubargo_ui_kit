import 'package:flutter/material.dart';
import 'package:rubargo_ui_kit/util/default_bargo_style.dart';

/// Definitive enumeration of the RuBargo text styles.
/// Style guide as per figma
/// https://www.figma.com/file/n0NCs7BUx9RdZgsoW3iJHq/Disarm-Russian-Design-System
enum BargoTextStyle {
  h1Heading,
  h2Heading,
  h3Heading,
  h4Heading,
  h4Text,
  h5Heading,
  h5Text,
  h5Subtext,
  h6Text,
  h6Subtext,
}

const _baseStyle = TextStyle(fontFamily: 'e-ukraine');

final stylesMap = <BargoTextStyle, TextStyle>{
  BargoTextStyle.h1Heading: _baseStyle.copyWith(fontSize: 56, height: 68 / 56),
  BargoTextStyle.h2Heading: _baseStyle.copyWith(fontSize: 38, height: 40 / 38),
  BargoTextStyle.h3Heading: _baseStyle.copyWith(fontSize: 24, height: 32 / 24),
  BargoTextStyle.h4Heading: _baseStyle.copyWith(fontSize: 18, height: 24 / 18),
  BargoTextStyle.h4Text: _baseStyle.copyWith(
    fontSize: 18,
    height: 24 / 18,
    fontWeight: FontWeight.w300,
  ),
  BargoTextStyle.h5Heading: _baseStyle.copyWith(fontSize: 16, height: 24 / 16),
  BargoTextStyle.h5Text: _baseStyle.copyWith(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w300,
  ),
  BargoTextStyle.h5Subtext: _baseStyle.copyWith(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w200,
  ),

  /// Should be all caps
  BargoTextStyle.h6Text: _baseStyle.copyWith(
    fontSize: 13,
    height: 20 / 13,
  ),

  BargoTextStyle.h6Subtext: _baseStyle.copyWith(
    fontSize: 13,
    height: 20 / 13,
    fontWeight: FontWeight.w300,
  ),
};

/// Implements rubargo typography.
/// Properties like color, decoration and others can be injected using
/// [DefaultTextStyle].
class BargoText extends StatelessWidget {
  const BargoText(
    this.text, {
    Key? key,
    this.style,
  }) : super(key: key);

  final BargoTextStyle? style;
  final String text;

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);

    final effectiveStyle =
        style ?? DefaultBargoTextStyle.of(context) ?? BargoTextStyle.h5Text;

    return Text(
      style == BargoTextStyle.h6Text ? text.toUpperCase() : text,
      style: defaultTextStyle.style.merge(stylesMap[effectiveStyle]),
    );
  }
}
