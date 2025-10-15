import 'package:flutter/material.dart';
import 'package:twogass/apps/core/helpers/color_helpers.dart';
import 'package:twogass/apps/core/helpers/icon_helpers.dart';
import 'package:twogass/apps/core/theme/box_shadow.dart';
import 'package:twogass/apps/data/model/activity_model.dart';
import 'package:yo_ui/yo_ui.dart';

class CardActivityWidget extends StatelessWidget {
  final ActivityModel model;
  final void Function()? onTap;
  const CardActivityWidget({super.key, required this.model, this.onTap});

  @override
  Widget build(BuildContext context) {
    final icon = IconHelpers.getActivityIcon(model.type);
    final color = ColorHelpers.getActivityColor(model.type);
    return Padding(
      padding: YoPadding.onlyBottom8,
      child: YoCard(
        elevation: 0,
        onTap: onTap,
        shadow: YoShadow.card(context),
        child: Row(
          spacing: YoSpacing.md,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: context.textColor, size: 22),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YoText.titleMedium(model.title),
                  YoText.bodyMedium(model.description),
                  YoText.bodySmall(
                    YoDateFormatter.formatRelativeTime(
                      DateTime.now().subtract(Duration(hours: 12)),
                    ),
                    color: context.gray500,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
