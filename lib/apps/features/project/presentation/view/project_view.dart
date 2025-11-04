import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/features/organization/presentation/controller/organization_controller.dart';
import 'package:twogass/apps/features/project/presentation/view/screen/project_comments_screen.dart';
import 'package:twogass/apps/features/project/presentation/view/screen/project_detail_screen.dart';
import 'package:twogass/apps/features/project/presentation/view/screen/project_task_screen.dart';
import 'package:twogass/apps/routes/route_names.dart';
import 'package:yo_ui/yo_ui.dart';

import '../controller/project_controller.dart';

class ProjectView extends GetView<ProjectController> {
  const ProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<ScaffoldState>();
    final orgColor = Get.find<OrganizationController>().org.value.color;
    return Obx(
      () => controller.isLoading.isFalse
          ? RefreshIndicator(
              onRefresh: () async {
                controller.initData();
              },
              child: Scaffold(
                floatingActionButton: Visibility(
                  visible: controller.isAssigner.value,
                  child: FloatingActionButton(
                    backgroundColor: Color(
                      orgColor ?? context.primaryColor.toARGB32(),
                    ),
                    onPressed: () async {
                      final result = await Get.toNamed(
                        RouteNames.TASK_CREATE,
                        arguments: {
                          "projectId": controller.id.value,
                          "orgId": controller.orgId.value,
                        },
                      );

                      if (result == true && context.mounted) {
                        YoSnackBar.show(
                          context: context,
                          message: "Task created successfully",
                          type: YoSnackBarType.success,
                        );
                      }
                    },
                    child: Icon(
                      Iconsax.note_add_outline,
                      color: context.onPrimaryColor,
                    ),
                  ),
                ),
                key: key,
                endDrawer: SafeArea(
                  child: YoDrawer(
                    header: Padding(
                      padding: YoPadding.all12,
                      child: YoText.titleMedium("Setting Project"),
                    ),
                    items: [
                      YoDrawerItem(
                        icon: Iconsax.profile_2user_outline,
                        title: "Member",
                        onTap: () {
                          controller.goToAssignProject();
                        },
                      ),
                      YoDrawerItem(
                        icon: Iconsax.edit_outline,
                        title: "Edit Project",
                        onTap: () {},
                      ),
                    ],
                    footer: Padding(
                      padding: YoPadding.only(bottom: YoSpacing.md),
                      child: Visibility(
                        visible: controller.project.value.createdBy == uid,
                        child: YoListTile(
                          leading: Icon(
                            Iconsax.trash_outline,
                            color: context.errorColor,
                          ),
                          title: "Delete Project",
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),
                ),
                appBar: AppBar(
                  title: YoText.titleLarge(
                    controller.project.value.name.capitalize!,
                  ),
                  centerTitle: true,
                  actions: [
                    Visibility(
                      visible: controller.isAssigner.value,
                      child: IconButton(
                        onPressed: () {
                          key.currentState!.openEndDrawer();
                        },
                        icon: Icon(Iconsax.setting_2_outline),
                      ),
                    ),
                  ],
                ),
                body: SafeArea(
                  child: ListView(
                    padding: YoPadding.all20,
                    physics: BouncingScrollPhysics(),
                    children: [
                      ProjectDetailScreen(),
                      SizedBox(height: YoSpacing.md),
                      ProjectTaskScreen(),
                      Visibility(
                        visible: controller.isAssigner.value,
                        child: Column(
                          children: [
                            SizedBox(height: YoSpacing.md),
                            ProjectCommentsScreen(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Scaffold(
              body: Center(
                child: YoLoading.spinner(color: context.primaryColor),
              ),
            ),
    );
  }
}
