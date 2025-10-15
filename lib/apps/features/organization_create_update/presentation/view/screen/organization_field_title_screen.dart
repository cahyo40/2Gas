import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/organization_create_update_controller.dart';

class OrganizationFieldTitleScreen
    extends GetView<OrganizationCreateUpdateController> {
  const OrganizationFieldTitleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YoText.titleMedium("Title"),
        SizedBox(height: YoSpacing.sm),
        TextFormField(
          readOnly: controller.isEdit.value,
          controller: controller.title,
          style: context.yoBodyMedium,
          validator: (value) =>
              YoValidator.validateRequired(value, fieldName: "title"),
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
