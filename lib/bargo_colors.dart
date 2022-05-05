import 'package:flutter/rendering.dart';

/// All available rubargo colors
class BargoColor {
  static const primary = Color(0xFF2F2F2F);
  static const press = Color(0xFF666666);
  static const placeholder = Color(0xFF999999);
  static const hint = Color(0xFFC7C7C7);
  static const disable = Color(0xFFE6E6E6);
  static const link = Color(0xFF3180F6);
  static const danger = Color(0xFFED4D28);
  static const warning = Color(0xFFF0893A);
  static const safe = Color(0xFF5AC269);
  static const stroke = Color(0xFFEFEFEF);
  static const backgorund = Color(0xFFEFEFEF);
  static const cardModalBg = Color(0xFFFBFBFB);
  static const middleground = Color(0xFFFDFDFD);
  static const foreground = Color(0xFFFFFFFF);
}

/// Gradient decorations.
/// Use [copyWith] method from [BoxDecoration] to add traits like border radius
class BargoDecoration {
  static const systemBg = BoxDecoration(
    color: Color(0x00000000),
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0x66000000),
        Color(0x66FFFFFF),
      ],
    ),
  );
  static const danger = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFFF17D62),
        Color(0xFFED4D28),
        Color(0xFFF49680),
      ],
    ),
  );
  static const warning = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFFF5B889),
        Color(0xFFF0893A),
        Color(0xFFF5B889),
      ],
    ),
  );
  static const safe = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFF9BD9A4),
        Color(0xFF5AC269),
        Color(0xFF9BD9A4),
      ],
    ),
  );
}
