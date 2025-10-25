import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/project_create_controller.dart';

class FieldCategoryProjectScreen extends GetView<ProjectCreateController> {
  const FieldCategoryProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YoText.titleMedium("Category"),
        SizedBox(height: YoSpacing.sm),
        Row(
          spacing: YoSpacing.md,
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.catCtrl,
                style: context.yoBodyMedium,
                decoration: InputDecoration(
                  hintText: "Category",
                  hintStyle: context.yoBodyMedium.copyWith(
                    color: context.gray500,
                  ),
                  filled: true,
                  fillColor: context.textColor.withValues(alpha: .025),
                ),
              ),
            ),
            IconButton.filled(
              color: context.primaryColor,
              onPressed: () {
                if (controller.catCtrl.text.isEmpty) {
                  YoSnackBar.show(
                    context: context,
                    message: "Isi kategorynya",
                    type: YoSnackBarType.error,
                  );
                } else {
                  controller.onAddCategory(controller.catCtrl.text);
                  controller.catCtrl.clear();
                  YoLogger.info(controller.category.toJson().toString());
                  FocusScope.of(context).unfocus();
                }
              },
              icon: Icon(
                Iconsax.add_circle_outline,
                color: context.colorTextBtn,
              ),
            ),
            IconButton.filled(
              color: context.accentColor,
              onPressed: () {},
              icon: Icon(Iconsax.category_2_bold, color: context.colorTextBtn),
            ),
          ],
        ),
        Obx(
          () => Wrap(
            spacing: YoSpacing.sm,
            children: List.generate(controller.category.length, (i) {
              final f = controller.category[i];
              return InkWell(
                onTap: () {
                  YoConfirmDialog.show(
                    context: context,
                    title: "Delete",
                    content: "Cateogry",
                    confirmText: "Yes",
                  ).then((onValue) {
                    if (onValue == true && context.mounted) {
                      controller.category.removeAt(i);
                      controller.category.refresh();
                      FocusScope.of(context).unfocus();
                    }
                  });
                },
                child: Chip(
                  label: YoText.bodySmall(f.name, color: context.textColor),
                ),
              );
            }),
          ),
        ),
        SizedBox(height: YoSpacing.md),
      ],
    );
  }
}
