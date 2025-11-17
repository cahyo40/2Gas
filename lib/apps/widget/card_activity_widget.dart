import 'package:flutter/material.dart';
import 'package:twogass/apps/core/helpers/activity_message.dart';
import 'package:twogass/apps/core/helpers/color_helpers.dart';
import 'package:twogass/apps/core/helpers/icon_helpers.dart';
import 'package:twogass/apps/data/model/activity_model.dart';
import 'package:yo_ui/yo_ui.dart';

class CardActivityWidget extends StatelessWidget {
  final ActivityModel model;
  final void Function()? onTap;
  const CardActivityWidget({super.key, required this.model, this.onTap});

  @override
  Widget build(BuildContext context) {
    final icon = IconHelpers.getActivityIcon(model.type);
    final color = YoColors().getActivityColor(model.type);
    return Padding(
      padding: YoPadding.onlyBottom8,
      child: YoCard(
        elevation: 0,
        onTap: onTap,
        shadows: YoBoxShadow.soft(context),
        border: Border.all(
          color: context.textColor.withValues(alpha: .2),
          width: 1,
        ),
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: color.withOpacity(0.3)),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YoText.bodyMedium(
                    ActivityMessageHelper.title(type: model.type),
                    fontWeight: FontWeight.w600,
                    maxLines: 2,
                  ),
                  SizedBox(height: 2),
                  YoText.bodySmall(
                    ActivityMessageHelper.description(
                      type: model.type,
                      data: model.meta!,
                    ),
                    color: Colors.grey.shade600,
                    maxLines: 3,
                  ),
                  SizedBox(height: 4),
                  YoText.bodySmall(
                    YoDateFormatter.formatRelativeTime(model.createdAt),
                    color: Colors.grey.shade500,
                    fontSize: 11,
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
