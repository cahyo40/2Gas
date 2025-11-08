import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/features/organization/presentation/controller/organization_controller.dart';
import 'package:twogass/apps/widget/user_listtile_widget.dart';
import 'package:yo_ui/yo_ui_base.dart';

import '../../controller/project_controller.dart';

String get uid => Get.find<AuthController>().uid;

class ProjectAssignScreen extends GetView<ProjectController> {
  const ProjectAssignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orgColor = Get.find<OrganizationController>().org.value.color;
    return Scaffold(
      appBar: YoAppBar(
        title: "Assign",
        backgroundColor: context.backgroundColor,
        actions: [
          Visibility(
            visible: controller.createdBy.value.uid == uid,
            child: YoButtonIcon.custom(
              backgroundColor: Color(
                orgColor ?? context.primaryColor.toARGB32(),
              ),
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
                          final bool isAssinger = controller
                              .project
                              .value
                              .assign
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
                    return Row(
                      spacing: 8,
                      children: [
                        Expanded(child: UserListtileWidget(uid: model.uid)),

                        controller.isCreator(model.uid)
                            ? YoChip(label: "CREATOR")
                            : Visibility(
                                visible:
                                    controller.project.value.status !=
                                        ProjectStatus.completed &&
                                    controller.project.value.createdBy == uid,
                                child: YoButtonIcon.custom(
                                  backgroundColor: Color(
                                    orgColor ?? context.primaryColor.toARGB32(),
                                  ),
                                  icon: Icon(
                                    Iconsax.trash_outline,
                                    color: context.onPrimaryColor,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                      ],
                    );
                  },
                ),
        ),
      ),
    );
  }
}
