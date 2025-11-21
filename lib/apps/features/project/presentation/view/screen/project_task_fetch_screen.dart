import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/organization/presentation/controller/organization_controller.dart';
import 'package:twogass/apps/features/project/presentation/controller/project_controller.dart';
import 'package:twogass/apps/routes/route_names.dart';
import 'package:twogass/apps/widget/card_task_widget.dart';
import 'package:yo_ui/yo_ui.dart';

class OrganizatonTaskScreen extends GetView<ProjectController> {
  const OrganizatonTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orgColor = Get.find<OrganizationController>().org.value.color;

    return Scaffold(
      floatingActionButton: Visibility(
        visible: controller.isAssigner.value,
        child: FloatingActionButton(
          backgroundColor: Color(orgColor ?? context.primaryColor.toARGB32()),
          onPressed: () async {
            final result = await Get.toNamed(
              RouteNames.TASK_CREATE,
              arguments: {
                "projectId": controller.id.value,
                "orgId": controller.orgId.value,
              },
            );
            if (result == true) {
              await controller.refreshTask();
              await Future.delayed(Duration(milliseconds: 500));
              if (context.mounted) {
                YoSnackBar.show(
                  context: context,
                  message: L10n.t.msg_success_create_task,
                  type: YoSnackBarType.success,
                );
              }
            }
          },
          child: Icon(Iconsax.note_add_outline, color: context.onPrimaryColor),
        ),
      ),
      appBar: AppBar(
        title: Obx(
          () => YoText.titleLarge(
            "${L10n.t.nav_project} ${controller.project.value.name}",
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.refreshTask();
        },
        child: Obx(() {
          return YoColumn(
            padding: YoPadding.all20,
            children: [
              Obx(
                () => Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: List.generate(
                    TaskStatus.values.length,
                    (i) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: controller.currentFilterTask.value == i
                            ? Color(orgColor ?? context.primaryColor.toARGB32())
                            : Colors.transparent,
                        border: Border.all(
                          color: controller.currentFilterTask.value == i
                              ? Colors.transparent
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => controller.onTaskFilter(i),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: YoText.bodyMedium(
                              TaskStatus.values[i].name.capitalize!,
                              color: controller.currentFilterTask.value == i
                                  ? context.onPrimaryColor
                                  : context.textColor,
                              fontWeight:
                                  controller.currentFilterTask.value == i
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: YoSpacing.lg),
              Expanded(
                child: controller.taskFilter.isEmpty
                    ? YoEmptyState.noData(
                        title: L10n.t.no_task_title,
                        description: L10n.t.no_task_desc,
                      )
                    : ListView.builder(
                        itemCount: controller.taskFilter.length,
                        itemBuilder: (_, index) {
                          final model = controller.taskFilter[index];
                          return CardTaskWidget(
                            model: model,
                            onTap: controller.isAssigner.isTrue
                                ? () {
                                    YoBottomSheet.show(
                                      maxHeight: context.height * 0.3,
                                      context: context,
                                      title: L10n.t.notif_task_updated_title,
                                      child: Column(
                                        children: TaskStatus.values
                                            .where((e) => e != TaskStatus.all)
                                            .toList()
                                            .map((status) {
                                              return YoListTile(
                                                title: _getStatusText(status),
                                                selected:
                                                    status == model.status,
                                                onTap: () {
                                                  Get.back();
                                                  controller.updateStatusTask(
                                                    model.id,
                                                    model.projectId,
                                                    status,
                                                  );
                                                },
                                              );
                                            })
                                            .toList(),
                                      ),
                                    );
                                  }
                                : null,
                            onLongPress: controller.isAssigner.isTrue
                                ? () {
                                    YoAdvancedConfirmDialog.show(
                                      context: context,
                                      title: L10n.t.msg_task_delete_title,
                                      content: L10n.t.msg_task_delete_content,
                                      confirmText: L10n.t.yes,
                                      cancelText: L10n.t.no,
                                      confirmVariant: YoButtonVariant.custom,
                                      confirmColor: context.primaryColor,
                                      cancelColor: context.errorColor,
                                    ).then((confirm) {
                                      if (confirm == true && context.mounted) {
                                        controller.onDeleteTask(model);
                                        YoSnackBar.show(
                                          context: context,
                                          message:
                                              L10n.t.msg_task_deleted_success,
                                          type: YoSnackBarType.success,
                                        );
                                      }
                                    });
                                  }
                                : null,
                          );
                        },
                      ),
              ),
            ],
          );
        }),
      ),
    );
  }

  String _getStatusText(TaskStatus status) {
    switch (status) {
      case TaskStatus.done:
        return L10n.t.task_done;
      case TaskStatus.progress:
        return L10n.t.task_in_progress;
      case TaskStatus.todo:
        return L10n.t.task_not_started;
      default:
        return L10n.t.all;
    }
  }
}
