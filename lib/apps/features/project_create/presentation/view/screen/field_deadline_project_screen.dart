import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/project_create_controller.dart';

class FieldDeadlineProjectScreen extends GetView<ProjectCreateController> {
  const FieldDeadlineProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YoText.titleMedium("Deadline"),
        SizedBox(height: YoSpacing.sm),
        TextFormField(
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
          style: context.yoBodyMedium,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            prefixIcon: Icon(Iconsax.calendar_2_outline),
            hintText: "Deadline",
            hintStyle: context.yoBodyMedium.copyWith(color: context.gray500),
            filled: true,
            fillColor: context.textColor.withValues(alpha: .025),
          ),
        ),
        SizedBox(height: YoSpacing.md),
      ],
    );
  }
}
