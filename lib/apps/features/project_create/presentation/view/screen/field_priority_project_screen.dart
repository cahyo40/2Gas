import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/l10n/generated/app_localizations.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/project_create_controller.dart';

class FieldPriorityProjectScreen extends GetView<ProjectCreateController> {
  const FieldPriorityProjectScreen({super.key});

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
            fillColor: context.cardColor,
            filled: true,
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
