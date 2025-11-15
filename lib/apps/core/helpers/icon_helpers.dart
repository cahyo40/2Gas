import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/data/model/activity_model.dart';

class IconHelpers {
  static IconData getActivityIcon(ActivityType type) {
    switch (type.category) {
      case 'Task':
        return Iconsax.task_square_outline;
      case 'Project':
        return Iconsax.folder_2_outline;
      case 'Member':
        return Iconsax.user_add_outline;
      case 'Comment':
        return Iconsax.message_text_outline;
      case 'Organization':
        return Iconsax.building_4_outline;
      case 'Attachment':
        return Iconsax.attach_circle_outline;
      case 'Label':
        return Iconsax.tag_2_outline;
      default:
        return Iconsax.activity_outline;
    }
  }

  static IconData getNotifiIcon(String notif) {
    if (notif.contains("org")) {
      return Iconsax.building_4_outline;
    } else if (notif.contains("project")) {
      return Iconsax.folder_2_outline;
    } else {
      return Iconsax.task_square_outline;
    }
  }
}
