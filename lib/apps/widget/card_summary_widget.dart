import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui_base.dart';

class CardSummaryWidget extends StatelessWidget {
  final String title;
  final int value;
  const CardSummaryWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return YoCard(
      backgroundColor: context.backgroundColor,
      shadows: YoBoxShadow.apple(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          YoText.bodyMedium(title),
          YoText.monoLarge(value.toStringAsFixed(0), fontSize: YoSpacing.xl),
        ],
      ),
    );
  }
}
