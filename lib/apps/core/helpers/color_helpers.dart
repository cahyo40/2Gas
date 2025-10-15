import 'package:flutter/material.dart';
import 'package:twogass/apps/data/model/activity_model.dart';

class ColorHelpers {
  static Color getActivityColor(ActivityType type) {
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
}
