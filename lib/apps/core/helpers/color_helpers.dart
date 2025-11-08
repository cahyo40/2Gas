import 'package:flutter/material.dart';
import 'package:twogass/apps/data/model/activity_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:yo_ui/yo_ui.dart';

extension ColorHelpers on YoColors {
  Color getActivityColor(ActivityType type) {
    final bool isDark =
        WidgetsBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark;

    switch (type.category) {
      case 'Task':
        return isDark ? Colors.blueAccent : Colors.blue;
      case 'Project':
        return isDark ? Colors.orangeAccent : Colors.orange;
      case 'Member':
        return isDark ? Colors.lightGreenAccent : Colors.green;
      case 'Comment':
        return isDark ? Colors.purpleAccent : Colors.purple;
      case 'Organization':
        return isDark ? Colors.cyanAccent : Colors.teal;
      case 'Attachment':
        return isDark ? Colors.indigoAccent : Colors.indigo;
      case 'Label':
        return isDark ? Colors.amberAccent : Colors.amber;
      default:
        return isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    }
  }

  Color getPriority(BuildContext context, Priority priority) {
    switch (priority) {
      case Priority.high:
        return context.errorColor;
      case Priority.medium:
        return context.warningColor;
      default:
        return context.infoColor;
    }
  }

  Color getStatus(TaskStatus status) {
    switch (status) {
      case TaskStatus.todo:
        return Colors.grey;
      case TaskStatus.progress:
        return Colors.orange;
      case TaskStatus.done:
        return Colors.green;
    }
  }

  Color getDeadlineColor(int daysLeft) {
    if (daysLeft < 0) {
      return Colors.red; // Overdue
    } else if (daysLeft <= 1) {
      return Colors.red; // Due today or tomorrow
    } else if (daysLeft <= 3) {
      return Colors.orange; // Due in 2-3 days
    } else {
      return Colors.grey.shade600; // Normal
    }
  }
}
