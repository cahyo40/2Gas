import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/features/project/presentation/controller/project_controller.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/task_create_controller.dart';

class FieldDeadlineTaskScreen extends GetView<TaskCreateController> {
  const FieldDeadlineTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final project = Get.find<ProjectController>().project;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YoTextFormField(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: project.value.deadline,
              initialDate: controller.deadline.value,
            );
            controller.deadline.value = date!;
            controller.deadlineCtrl.text = YoDateFormatter.formatDate(date);
          },
          controller: controller.deadlineCtrl,
          readOnly: true,
          labelText: L10n.t.deadline,
          inputStyle: YoInputStyle.modern,
          prefixIcon: Icon(Iconsax.calendar_2_outline),
        ),

        SizedBox(height: YoSpacing.md),
      ],
    );
  }
}
