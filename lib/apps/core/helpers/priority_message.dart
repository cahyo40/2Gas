import 'package:flutter/material.dart';
import 'package:twogass/apps/data/model/task_model.dart';

class PriorityMessage {
  String call(BuildContext context, Priority priority) {
    switch (priority) {
      case Priority.high:
        return "High";
      case Priority.medium:
        return "Medium";
      default:
        return "Low";
    }
  }
}
