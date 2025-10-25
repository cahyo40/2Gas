import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/widget/user_listtile_widget.dart';
import 'package:yo_ui/yo_ui_base.dart';

import '../../controller/project_controller.dart';

class ProjectAssignScreen extends GetView<ProjectController> {
  const ProjectAssignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          YoText.titleMedium("Assign"),
          Divider(),
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: YoPadding.all16,
                itemCount: controller.assignProject.length,
                itemBuilder: (_, i) {
                  final model = controller.assignProject[i];
                  return UserListtileWidget(uid: model.uid);
                },
              ),
            ),
          ),
          YoButton.secondary(
            icon: Icon(Iconsax.user_add_outline, color: context.colorTextBtn),
            text: "Add Member",
            textColor: context.colorTextBtn,
            onPressed: () {},
          ),
          SizedBox(height: YoSpacing.lg),
        ],
      ),
    );
  }
}
