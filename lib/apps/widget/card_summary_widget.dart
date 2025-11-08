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
      shadows: YoBoxShadow.apple(color: context.textColor),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          YoText.bodySmall(
            title.toUpperCase(),
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
          SizedBox(height: 4),
          YoText.monoLarge(
            value.toString(),
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
