import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/core/helpers/color_helpers.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/organization/presentation/controller/organization_controller.dart';
import 'package:twogass/apps/features/project/presentation/controller/project_controller.dart';
import 'package:twogass/apps/routes/route_names.dart';
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
            "${L10n.t.task} ${controller.project.value.name} (${controller.task.length})",
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.refreshTask();
        },
        child: Obx(() {
          final kanbanKey = ValueKey(
            'kanban_${controller.task.length}_${YoIdGenerator.alphanumericId()}',
          );
          return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: _buildKanbanBoard(context, kanbanKey),
          );
        }),
      ),
    );
  }

  Widget _buildKanbanBoard(BuildContext context, Key key) {
    return YoKanbanBoard(
      key: key,
      dragEnabled: controller.isAssigner.value,
      columnWidth: Get.width - 40,
      onItemTap: (item, columnId) {
        // Handle item tap
        _showTaskDetails(item.id);
      },
      onItemMoved: (item, fromId, toId) async {
        List getId = item.id.split("_");
        final taskId = getId[0];
        final projectId = getId[1];

        await controller.updateStatusTask(taskId, projectId, _getStatus(toId));
      },
      height: Get.height - 200,
      columns: TaskStatus.values.where((e) => e != TaskStatus.all).map((
        status,
      ) {
        // Filter tasks by status
        final statusTasks = controller.task
            .where((task) => task.status.name == status.name)
            .toList();

        return YoKanbanColumn(
          id: status.name,
          title: status.name.capitalize!,
          items: statusTasks.map((task) {
            final daysLeft = task.deadline.difference(DateTime.now()).inDays;
            final isOverdue = daysLeft < 0;
            final isUrgent = daysLeft <= 3 && daysLeft >= 0;
            return YoKanbanItem(
              id: "${task.id}_${task.projectId}",
              title: task.name,
              description: task.description,
              priority: _getPriorityValue(task.priority.name),
              color: YoColors().getStatus(context, status),
              customWidgets: [
                Visibility(
                  visible: task.status != TaskStatus.done,
                  child: Column(
                    spacing: YoSpacing.md,
                    children: [
                      Row(
                        spacing: context.yoSpacingSm,

                        children: [
                          Expanded(
                            child: YoAvatarOverlap.horizontal(
                              imageUrls: task.assigns
                                  .map((e) => e.imageUrl)
                                  .toList(),
                              overlap: .6,
                              size: YoAvatarSize.xs,
                              maxDisplay: 3,
                            ),
                          ),
                          SizedBox(width: 4),
                          YoButtonIcon.primary(
                            size: YoIconButtonSize.small,
                            icon: Icon(Iconsax.user_add_outline),
                            onPressed: () {},

                            iconColor: context.onPrimaryColor,
                          ),
                          YoButtonIcon.custom(
                            size: YoIconButtonSize.small,
                            icon: Icon(Iconsax.trash_outline),
                            onPressed: () {
                              YoAdvancedConfirmDialog.show(
                                context: context,
                                title: L10n.t.msg_task_delete_title,
                                content: L10n.t.msg_task_delete_content,
                                confirmText: L10n.t.yes,
                                cancelText: L10n.t.no,

                                cancelColor: context.errorColor,
                              ).then((confirm) {
                                if (confirm == true && context.mounted) {
                                  controller.onDeleteTask(task);
                                  YoSnackBar.show(
                                    context: context,
                                    message: L10n.t.msg_task_deleted_success,
                                    type: YoSnackBarType.success,
                                  );
                                }
                              });
                            },
                            backgroundColor: context.errorColor,
                            iconColor: context.onPrimaryColor,
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Spacer(),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 12,
                                color: YoColors().getDeadlineColor(daysLeft),
                              ),
                              SizedBox(width: 4),
                              YoText.bodySmall(
                                "${YoDateFormatter.formatDate(task.deadline)} (${YoDateFormatter.daysBetween(DateTime.now(), task.deadline)} Days)",
                                color: YoColors().getDeadlineColor(daysLeft),
                                fontWeight: isOverdue || isUrgent
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
              tags: [],
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  // Helper methods
  int _getPriorityValue(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return 3;
      case 'medium':
        return 2;
      case 'low':
        return 1;
      default:
        return 0;
    }
  }

  TaskStatus _getStatus(String stat) {
    switch (stat) {
      case "done":
        return TaskStatus.done;
      case "progress":
        return TaskStatus.progress;
      default:
        return TaskStatus.todo;
    }
  }

  void _showTaskDetails(String itemId) {
    // Implement task details view
    List getId = itemId.split("_");
    final taskId = getId[0];

    final task = controller.task.firstWhere(
      (task) => task.id == taskId,
      orElse: () => TaskModel.initial(),
    );

    if (task.id.isNotEmpty) {
      // Show task details
      Get.dialog(
        AlertDialog(
          title: YoText.titleLarge(task.name),
          content: YoText.bodyMedium(task.description ?? L10n.t.no_description),

          actions: [
            YoButton.ghost(
              text: L10n.t.close,
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      );
    }
  }
}
