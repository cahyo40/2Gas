import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/l10n/generated/app_localizations.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/task_create_controller.dart';

class FieldPriorityTaskScreen extends GetView<TaskCreateController> {
  const FieldPriorityTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YoText.titleMedium(tr.field_priority),
        SizedBox(height: YoSpacing.sm),
        DropdownButtonFormField(
          onChanged: (value) {
            controller.priority.value = controller.onSelectPriority(value!);
            FocusScope.of(context).unfocus();
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: context.cardColor,
            hintText: tr.field_priority_hint,
            hintStyle: context.yoBodyMedium.copyWith(color: context.gray500),
          ),
          items: Priority.values.map((e) {
            return DropdownMenuItem(
              value: e.name,
              child: YoText.bodyMedium(e.name.capitalize!),
            );
          }).toList(),
        ),

        SizedBox(height: YoSpacing.md),
      ],
    );
  }
}
