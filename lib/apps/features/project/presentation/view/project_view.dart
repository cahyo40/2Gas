import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/data/model/task_model.dart';
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

                      if (result == true) {
                        YoSnackBar.show(
                          context: context,
                          message: L10n.t.msg_success_create_task,
                          type: YoSnackBarType.success,
                        );
                        controller.initData(useLoading: true);
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
                      child: YoText.titleMedium(L10n.t.setting_project),
                    ),
                    items: [
                      YoDrawerItem(
                        icon: Iconsax.profile_2user_outline,
                        title: L10n.t.member,
                        onTap: () {
                          controller.goToAssignProject();
                        },
                      ),

                      YoDrawerItem(
                        icon: Iconsax.edit_outline,
                        title: L10n.t.change_prioriy,
                        onTap: () {
                          YoBottomSheet.show(
                            context: context,
                            title: L10n.t.select_priority,
                            maxHeight: 300,
                            child: Obx(
                              () => Column(
                                children: Priority.values.map((p) {
                                  return YoListTile(
                                    title: p.name.capitalize,
                                    onTap: () async {
                                      await controller.updatePriority(p);
                                      Get.back();
                                    },
                                    selected:
                                        p == controller.project.value.priority,
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                      YoDrawerItem(
                        icon: Iconsax.calendar_edit_outline,
                        title: L10n.t.change_deadline,
                        subtitle: YoDateFormatter.formatDate(
                          controller.project.value.deadline,
                        ),
                        onTap: () async {
                          final date = await YoDialogPicker.date(
                            context: context,
                            initialDate: controller.project.value.deadline,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(
                              DateTime.now().year + 5,
                              DateTime.now().month,
                            ),
                          );
                          if (date != null) {
                            await controller.updateDeadline(date);
                          }
                        },
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
                          title: L10n.t.delete_project,
                          onTap: () {
                            Get.back();
                            YoAdvancedConfirmDialog.show(
                              context: context,
                              title: L10n.t.dialog_project_title,
                              content: L10n.t.dialog_project_content,
                              confirmText: L10n.t.yes,
                              confirmVariant: YoButtonVariant.custom,
                              confirmColor: context.primaryColor,
                              cancelText: L10n.t.no,
                            ).then((confirm) {
                              if (confirm == true && context.mounted) {
                                controller.onDeleteProject();
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                appBar: YoAppBar(
                  title: controller.project.value.name.capitalize!,

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
                            YoButton.custom(
                              backgroundColor: Color(
                                orgColor ?? context.primaryColor.toARGB32(),
                              ),
                              textColor: context.onPrimaryColor,
                              text: L10n.t.show_comments,
                              expanded: true,
                              onPressed: () async {
                                controller.comments.value = await controller
                                    .fetchComment(controller.id.value);
                                Get.to(() => ProjectCommentsScreen());
                              },
                            ),
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
