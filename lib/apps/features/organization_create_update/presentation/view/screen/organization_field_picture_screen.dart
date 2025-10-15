import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/organization_create_update_controller.dart';

class OrganizationFieldPictureScreen
    extends GetView<OrganizationCreateUpdateController> {
  const OrganizationFieldPictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        YoText.titleMedium("Logo Organization"),
        SizedBox(height: YoSpacing.sm),
        InkWell(
          onTap: () async {},
          child: Container(
            height: Get.width * 0.3,
            width: Get.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: YoSpacing.borderRadiusMd,
              color: context.textColor.withValues(alpha: .025),
            ),
            child: Center(
              child: Obx(
                () => controller.imageFile.value == null
                    ? Icon(
                        Iconsax.gallery_add_outline,
                        size: Get.width * 0.1,
                        color: context.textColor,
                      )
                    : Image.file(
                        controller.imageFile.value!,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
        ),
        SizedBox(height: YoSpacing.md),
      ],
    );
  }
}
