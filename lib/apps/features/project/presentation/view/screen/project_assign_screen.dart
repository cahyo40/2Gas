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
    return Scaffold(
      appBar: YoAppBar(
        title: "Assign",
        backgroundColor: context.backgroundColor,
        actions: [
          YoButtonIcon(
            icon: Icon(Iconsax.user_add_outline, color: context.colorTextBtn),
            onPressed: () {
              YoDialog.show(
                context: context,
                title: "Member",
                content: "Daftar Member Org",
                actions: [
                  Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: controller.members.length,
                      itemBuilder: (_, index) {
                        final member = controller.members[index];
                        final bool isAssinger = controller.project.value.assign
                            .any((e) => e.uid == member.uid);
                        return YoListTile(
                          leading: YoAvatar.image(imageUrl: member.imageUrl),
                          title: member.name,
                          subtitle: member.role.name.capitalize,
                          onTap: () async {
                            if (!isAssinger) {
                              YoConfirmDialog.show(
                                context: context,
                                title: "title",
                                content: "content",
                                confirmText: "Yes",
                              ).then((confirm) async {
                                if (confirm == true) {
                                  await controller.addAssigner(member);
                                  Get.back();
                                }
                              });
                            }
                          },
                          trailing: Visibility(
                            visible: isAssinger,
                            child: Icon(
                              Iconsax.tick_square_outline,
                              color: context.successColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          YoSpace.widthXs(),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.isTrue
              ? Center(child: YoLoading())
              : ListView.builder(
                  padding: YoPadding.all16,
                  itemCount: controller.assignProject.length,
                  itemBuilder: (_, i) {
                    final model = controller.assignProject[i];
                    return UserListtileWidget(uid: model.uid);
                  },
                ),
        ),
      ),
    );
  }
}
