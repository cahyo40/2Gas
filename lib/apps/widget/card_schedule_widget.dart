import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/core/theme/box_shadow.dart';
import 'package:twogass/apps/data/model/schedule_model.dart';
import 'package:yo_ui/yo_ui.dart';

class CardScheduleWidget extends StatelessWidget {
  final ScheduleModel model;
  final void Function()? onTap;
  final bool? showDate;
  const CardScheduleWidget({
    super.key,
    required this.model,
    this.onTap,
    this.showDate = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: YoPadding.onlyBottom8,
      child: YoCard(
        backgroundColor: context.backgroundColor,
        onTap: onTap,
        shadow: YoShadow.card(context),
        child: Column(
          spacing: YoSpacing.sm,
          children: [
            _cardScheduleItem(
              context: context,
              icon: FontAwesome.calendar_day_solid,
              content: model.title,
            ),
            if (model.type == "private")
              _cardScheduleItem(
                context: context,
                icon: FontAwesome.user_solid,
                content: "Pribadi",
              )
            else
              _cardScheduleItem(
                context: context,
                icon: FontAwesome.people_group_solid,
                content: "Id Organisasi",
              ),

            if (showDate == true)
              _cardScheduleItem(
                context: context,
                icon: FontAwesome.clock_solid,
                content: YoDateFormatter.isToday(model.date)
                    ? YoDateFormatter.formatTime(model.date)
                    : YoDateFormatter.formatDateTime(model.date),
              ),
          ],
        ),
      ),
    );
  }

  Row _cardScheduleItem({
    required IconData icon,
    required String content,
    required BuildContext context,
  }) {
    return Row(
      spacing: YoSpacing.sm,
      children: [
        CircleAvatar(
          radius: YoSpacing.md,
          backgroundColor: context.primaryColor.withValues(alpha: .25),
          child: Icon(icon, color: context.textColor, size: YoSpacing.md),
        ),
        YoText.bodySmall(content, color: context.textColor),
      ],
    );
  }
}
