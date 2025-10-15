import 'package:flutter/material.dart';
import 'package:twogass/apps/core/theme/box_shadow.dart';
import 'package:yo_ui/yo_ui_base.dart';

class CardSummaryWidget extends StatelessWidget {
  final String title;
  final double value;
  const CardSummaryWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return YoCard(
      backgroundColor: context.backgroundColor,
      shadow: YoShadow.card(context),
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
