import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/features/project/presentation/controller/project_controller.dart';
import 'package:twogass/apps/widget/avatar_overlapping_widget.dart';
import 'package:twogass/apps/widget/user_listtile_widget.dart';
import 'package:twogass/l10n/generated/app_localizations.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/task_create_controller.dart';

class FieldAssignsTaskScreen extends GetView<TaskCreateController> {
  const FieldAssignsTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final project = Get.find<ProjectController>();
    final tr = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YoText.titleMedium(tr.field_assigns),
        SizedBox(height: YoSpacing.sm),
        Row(
          spacing: YoSpacing.md,
          children: [
            IconButton.filled(
              onPressed: () {
                YoBottomSheet.show(
                  context: context,
                  title: tr.select_members,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: project.project.value.assign.length,
                    itemBuilder: (_, i) {
                      final member = project.project.value.assign[i];
                      return UserListtileWidget(
                        uid: member.uid,
                        isSelected: controller.isAssignMember(member),
                        onTap: () {
                          controller.onAssignMember(member);
                          Get.back();
                        },
                      );
                    },
                  ),
                );
              },
              icon: Icon(Iconsax.user_add_outline, color: context.colorTextBtn),
            ),
            Expanded(
              child: Obx(
                () => controller.assigns.isEmpty
                    ? SizedBox.shrink()
                    : AvatarOverlappingWidget(
                        imagesUrl: controller.assigns
                            .map((e) => e.imageUrl)
                            .toList(),
                      ),
              ),
            ),
          ],
        ),
        SizedBox(height: YoSpacing.xl),
      ],
    );
  }
}
