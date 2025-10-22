import 'package:flutter/material.dart';
import 'package:twogass/apps/core/helpers/color_helpers.dart';
import 'package:twogass/apps/core/helpers/priority_message.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:yo_ui/yo_ui.dart';

class PriorityWidget extends StatelessWidget {
  final Priority priority;
  const PriorityWidget({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: context.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: YoSpacing.borderRadiusMd,
        side: BorderSide(color: YoColors().getPriority(context, priority)),
      ),
      label: YoText.bodyMedium(
        PriorityMessage().call(context, priority),
        fontSize: context.yoBodySmall.fontSize,
        color: YoColors().getPriority(context, priority),
      ),
    );
  }
}
