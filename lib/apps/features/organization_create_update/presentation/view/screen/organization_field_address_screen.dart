import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/organization_create_update_controller.dart';

class OrganizationFieldAddressScreen
    extends GetView<OrganizationCreateUpdateController> {
  const OrganizationFieldAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YoText.titleMedium("Address"),
        SizedBox(height: YoSpacing.sm),
        TextFormField(
          readOnly: controller.isEdit.value,
          controller: controller.address,
          style: context.yoBodyMedium,
          decoration: InputDecoration(
            hintText: "Address",
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
