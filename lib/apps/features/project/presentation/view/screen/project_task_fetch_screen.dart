import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/core/helpers/color_helpers.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/organization/presentation/controller/organization_controller.dart';
import 'package:twogass/apps/features/project/presentation/controller/project_controller.dart';
import 'package:twogass/apps/routes/route_names.dart';
import 'package:twogass/apps/widget/avatar_overlapping_widget.dart';
import 'package:twogass/apps/widget/user_listtile_widget.dart';
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
            "${L10n.t.task} ${controller.project.value.name} (${controller.taskNew.length})",
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.refreshTask();
        },
        child: Obx(() {
          final kanbanKey = ValueKey(
            'kanban_${controller.taskNew.length}_${YoIdGenerator.alphanumericId()}',
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
        final statusTasks = controller.taskNew
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
                UserListtileWidget(
                  uid: task.createdBy,
                  size: UserListTileSize.small,
                ),
                Visibility(
                  visible: task.status != TaskStatus.done,
                  child: Row(
                    children: [
                      Expanded(
                        child: AvatarOverlappingWidget(
                          imagesUrl: task.assigns
                              .map((e) => e.imageUrl)
                              .toList(),
                          width: .6,
                          avatarRadius: 12,
                          maxDisplay: 3,
                        ),
                      ),
                      SizedBox(width: 4),
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

    final task = controller.taskNew.firstWhere(
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
            TextButton(
              onPressed: () => Get.back(),
              child: YoText.bodyMedium(L10n.t.close),
            ),
          ],
        ),
      );
    }
  }
}
