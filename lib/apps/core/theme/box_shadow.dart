import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui.dart';

class YoShadow {
  YoShadow._();

  static BoxShadow card(BuildContext context) => BoxShadow(
    color: context.textColor.withValues(alpha: .15),
    blurRadius: 10,
    offset: Offset(0, 4),
    spreadRadius: -2, // agar bayangan tidak melebar terlalu lebar
  );
}
