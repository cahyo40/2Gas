import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/core/helpers/validation_helpers.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/project_create_controller.dart';

class FieldTitleProjectScreen extends GetView<ProjectCreateController> {
  const FieldTitleProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YoText.titleMedium("Title"),
        SizedBox(height: YoSpacing.sm),
        TextFormField(
          controller: controller.name,
          style: context.yoBodyMedium,
          validator: (value) =>
              YoFormValidation.required(value, field: "Title"),
          decoration: InputDecoration(
            hintText: "Title",
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
