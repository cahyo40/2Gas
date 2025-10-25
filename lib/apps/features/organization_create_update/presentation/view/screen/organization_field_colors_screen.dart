import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/organization_create_update_controller.dart';

class OrganizationFieldColorsScreen
    extends GetView<OrganizationCreateUpdateController> {
  const OrganizationFieldColorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        YoText.titleMedium("Color Organization"),
        SizedBox(height: YoSpacing.sm),
        InkWell(
          onTap: () {
            YoBottomSheet.show(
              context: context,
              title: "Change Color",

              child: Column(
                children: [
                  Obx(
                    () => ColorPicker(
                      pickerColor: controller.colors.value,
                      onColorChanged: (color) {
                        controller.colors.value = color;
                      },
                    ),
                  ),
                  SizedBox(height: YoSpacing.sm),
                  YoButton.primary(
                    text: "Save",
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            );
          },
          child: Obx(
            () => Container(
              height: Get.width * 0.3,
              width: Get.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: YoSpacing.borderRadiusMd,
                color: controller.colors.value,
              ),
              child: Center(
                child: Icon(
                  Iconsax.paintbucket_outline,
                  size: Get.width * 0.1,
                  color: context.onPrimaryColor,
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
