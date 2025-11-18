import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/core/helpers/color_helpers.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/widget/card_task_user_shimmer_widget.dart';
import 'package:twogass/apps/widget/card_task_user_widget.dart';
import 'package:yo_ui/yo_ui.dart';

import '../controller/task_controller.dart';

class TaskView extends GetView<TaskController> {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () => controller.iniData(),
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                spacing: context.yoSpacingMd,
                children: [
                  Row(
                    spacing: context.yoSpacingMd,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: Obx(
                            () => DropdownButton<TaskStatus>(
                              value: controller.taskFilter.value,
                              onChanged: (TaskStatus? newValue) {
                                if (newValue != null) {
                                  controller.onFilterTask(newValue);
                                }
                              },
                              items: TaskStatus.values.map((TaskStatus status) {
                                return DropdownMenuItem<TaskStatus>(
                                  value: status,
                                  child: Row(
                                    children: [
                                      // Icon sesuai status
                                      Icon(
                                        _getStatusIcon(status),
                                        size: 16,
                                        color: YoColors().getStatus(
                                          context,
                                          status,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      YoText.bodyMedium(
                                        _getStatusText(status),
                                        color: YoColors().getStatus(
                                          context,
                                          status,
                                        ),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              // Styling untuk dropdown
                              isExpanded: true,
                              underline: Container(
                                height: 1,
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              elevation: 2,
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: Obx(
                            () => DropdownButton<int>(
                              value: controller.projectFilter.value,
                              onChanged: (int? newValue) {
                                controller.onProjectFilter(newValue!);
                              },
                              items: [
                                // Opsi "Semuanya" dengan value 0
                                DropdownMenuItem<int>(
                                  value: 0,
                                  child: YoText.bodyMedium(
                                    'Semuanya',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                // Opsi project dengan value index + 1
                                ...controller.projects.asMap().entries.map((
                                  entry,
                                ) {
                                  final index = entry.key;
                                  final project = entry.value;
                                  return DropdownMenuItem<int>(
                                    value:
                                        index +
                                        1, // +1 karena index 0 sudah dipakai untuk "Semuanya"
                                    child: YoText.bodyMedium(
                                      project.name,

                                      fontWeight: FontWeight.w500,

                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  );
                                }),
                              ],
                              isExpanded: true,
                              underline: Container(
                                height: 1,
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      YoButtonIcon.custom(
                        icon: Icon(
                          Iconsax.filter_remove_outline,
                          color: context.onPrimaryColor,
                        ),
                        onPressed: controller.resetFilter,
                      ),
                    ],
                  ),

                  Expanded(
                    child: Obx(
                      () => controller.taskShow.isNotEmpty
                          ? ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: controller.taskShow.length,
                              itemBuilder: (_, index) {
                                final task = controller.taskShow[index];
                                final project = controller.projects.firstWhere(
                                  (d) => d.id == task.projectId,
                                );
                                if (controller.isLoading.isTrue) {
                                  return CardTaskUserShimmer();
                                } else {
                                  return CardTaskUserWidget(
                                    task: task,
                                    project: project,
                                  );
                                }
                              },
                            )
                          : YoEmptyState.noData(
                              title: L10n.t.no_task_title,
                              description: L10n.t.no_task_desc,
                              actionText: L10n.t.refresh,
                              onAction: () =>
                                  controller.iniData(useLoading: true),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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

  IconData _getStatusIcon(TaskStatus status) {
    switch (status) {
      case TaskStatus.done:
        return Icons.check_circle_outline;
      case TaskStatus.progress:
        return Icons.autorenew;
      case TaskStatus.todo:
        return Icons.radio_button_unchecked;
      default:
        return Icons.all_inbox_sharp;
    }
  }
}
