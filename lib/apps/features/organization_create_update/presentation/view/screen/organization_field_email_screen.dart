import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/organization_create_update_controller.dart';

class OrganizationFieldEmailScreen
    extends GetView<OrganizationCreateUpdateController> {
  const OrganizationFieldEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YoText.titleMedium("Email"),
        SizedBox(height: YoSpacing.sm),
        TextFormField(
          readOnly: controller.isEdit.value,
          keyboardType: TextInputType.emailAddress,
          controller: controller.email,
          style: context.yoBodyMedium,
          validator: (value) => YoValidator.validateEmail(value),
          decoration: InputDecoration(
            hintText: "Email",
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
