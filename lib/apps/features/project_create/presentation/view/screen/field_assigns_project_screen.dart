import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/widget/avatar_overlapping_widget.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/project_create_controller.dart';

class FieldAssignsProjectScreen extends GetView<ProjectCreateController> {
  const FieldAssignsProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YoText.titleMedium("Assigns"),
        SizedBox(height: YoSpacing.sm),

        Row(
          spacing: YoSpacing.md,
          children: [
            IconButton.filled(
              onPressed: () {
                YoBottomSheet.show(
                  context: context,
                  title: "Select Member",
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: controller.initialMember.length,
                    itemBuilder: (_, i) {
                      final member = controller.initialMember[i];
                      return Padding(
                        padding: YoPadding.onlyBottom8,
                        child: YoCard(
                          backgroundColor: context.backgroundColor,
                          shadows: YoBoxShadow.apple(),
                          child: ListTile(
                            onTap: () {
                              controller.onAssignMember(member);
                              Get.back();
                            },
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(member.imageUrl),
                            ),
                            title: YoText.bodyMedium(member.name),
                            subtitle: YoText.bodySmall(member.email),
                            trailing: Obx(
                              () => controller.isAssignMember(member)
                                  ? Icon(
                                      Iconsax.tick_square_bold,
                                      color: context.successColor,
                                    )
                                  : SizedBox.shrink(),
                            ),
                          ),
                        ),
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
        SizedBox(height: YoSpacing.md),
      ],
    );
  }
}
