import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/project_create_controller.dart';

class FieldDeadlineProjectScreen extends GetView<ProjectCreateController> {
  const FieldDeadlineProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YoTextFormField(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime(DateTime.now().year + 5),
              initialDate: controller.deadline.value,
            );
            controller.deadline.value = date!;
            controller.deadlineCtrl.text = YoDateFormatter.formatDate(date);
          },
          controller: controller.deadlineCtrl,
          readOnly: true,
          labelText: "Deadline",
          inputStyle: YoInputStyle.modern,
        ),

        SizedBox(height: YoSpacing.md),
      ],
    );
  }
}
