import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/organization_create_update_controller.dart';

class OrganizationFieldDescScreen
    extends GetView<OrganizationCreateUpdateController> {
  const OrganizationFieldDescScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YoText.titleMedium("Description"),
        SizedBox(height: YoSpacing.sm),
        TextFormField(
          readOnly: controller.isEdit.value,
          controller: controller.desc,
          style: context.yoBodyMedium,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: "Description",
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
