import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/l10n/generated/app_localizations.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/project_create_controller.dart';

class FieldCategoryProjectScreen extends GetView<ProjectCreateController> {
  const FieldCategoryProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: YoSpacing.md,
          children: [
            Expanded(
              child: YoTextFormField(
                controller: controller.catCtrl,
                inputStyle: YoInputStyle.modern,
                labelText: tr.field_category,
              ),
            ),
            IconButton.filled(
              color: context.primaryColor,
              onPressed: () {
                if (controller.catCtrl.text.isEmpty) {
                  YoSnackBar.show(
                    context: context,
                    message: tr.field_category_msg_required,
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
                    title: tr.field_categoory_delete_title,
                    content: tr.field_categoory_delete_message,
                    confirmText: tr.yes,
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
