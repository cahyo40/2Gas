import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/features/organization/presentation/controller/organization_controller.dart';
import 'package:twogass/apps/features/project/presentation/view/screen/project_assign_screen.dart';
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
                endDrawer: Drawer(
                  backgroundColor: context.backgroundColor,
                  width: Get.width * 0.8,
                  child: ProjectAssignScreen(),
                ),
                appBar: AppBar(
                  title: YoText.titleLarge(
                    controller.project.value.name.capitalize!,
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      onPressed: () {
                        key.currentState!.openEndDrawer();
                      },
                      icon: Icon(Iconsax.profile_2user_outline),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Iconsax.setting_2_outline),
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
