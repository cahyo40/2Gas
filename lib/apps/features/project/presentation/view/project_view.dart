import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/features/project/presentation/view/screen/project_assign_screen.dart';
import 'package:twogass/apps/features/project/presentation/view/screen/project_comments_screen.dart';
import 'package:twogass/apps/features/project/presentation/view/screen/project_detail_screen.dart';
import 'package:twogass/apps/features/project/presentation/view/screen/project_task_screen.dart';
import 'package:yo_ui/yo_ui.dart';

import '../controller/project_controller.dart';

class ProjectView extends GetView<ProjectController> {
  const ProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<ScaffoldState>();
    return Obx(
      () => controller.isLoading.isFalse
          ? RefreshIndicator(
              onRefresh: () async {
                controller.initData();
              },
              child: Scaffold(
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
                    physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      ProjectDetailScreen(),
                      SizedBox(height: YoSpacing.md),
                      ProjectTaskScreen(),
                      SizedBox(height: YoSpacing.md),
                      ProjectCommentsScreen(),
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
