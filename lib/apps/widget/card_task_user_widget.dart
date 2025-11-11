import 'package:flutter/material.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:yo_ui/yo_ui.dart';

class CardTaskUserWidget extends StatelessWidget {
  final TaskModel task;
  final ProjectModel project;
  final void Function()? onTap;
  const CardTaskUserWidget({
    super.key,
    required this.task,
    required this.project,
    this.onTap,
  });

  Color _getPriorityColor(Priority priority, BuildContext context) {
    switch (priority) {
      case Priority.high:
        return Colors.red;
      case Priority.medium:
        return Colors.orange;
      case Priority.low:
        return Colors.green;
    }
  }

  Color _getStatusColor(TaskStatus status, BuildContext context) {
    switch (status) {
      case TaskStatus.done:
        return Colors.green;
      case TaskStatus.progress:
        return Colors.blue;
      case TaskStatus.todo:
        return Colors.grey;
      default:
        return context.primaryColor;
    }
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

  @override
  Widget build(BuildContext context) {
    final isOverdue = task.deadline.isBefore(DateTime.now());
    final daysLeft = task.deadline.difference(DateTime.now()).inDays;

    return Padding(
      padding: EdgeInsets.only(bottom: context.yoSpacingMd),
      child: YoCard(
        onTap: onTap,
        padding: const EdgeInsets.all(16),
        elevation: 0,
        border: Border.all(
          color: context.textColor.withValues(alpha: .2),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan priority indicator dan project name
            Row(
              children: [
                // Priority indicator
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    color: _getPriorityColor(task.priority, context),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                // Project name
                Expanded(
                  child: YoText.labelSmall(
                    project.name,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Task title
            YoText.titleMedium(
              task.name,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),

            // Task description (jika ada)
            if (task.description != null && task.description!.isNotEmpty) ...[
              const SizedBox(height: 6),
              YoText.bodySmall(
                task.description!,
                color: Colors.grey.shade600,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],

            const SizedBox(height: 12),

            // Status dan deadline row
            Row(
              children: [
                // Status badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(
                      task.status,
                      context,
                    ).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: _getStatusColor(
                        task.status,
                        context,
                      ).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: YoText.labelSmall(
                    _getStatusText(task.status),
                    color: _getStatusColor(task.status, context),
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                  ),
                ),

                const Spacer(),

                // Deadline info - hanya ditampilkan jika task belum selesai
                if (task.status != TaskStatus.done) ...[
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: isOverdue ? Colors.red : Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      YoText.labelSmall(
                        isOverdue
                            ? L10n.t.overdue_by_day(daysLeft)
                            : daysLeft <= 1
                            ? L10n.t.due_tomorrow
                            : L10n.t.due_in_days(daysLeft),
                        color: isOverdue ? Colors.red : Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ],
            ),

            // Progress bar (opsional, untuk visualisasi progress)
            if (task.status == TaskStatus.progress) ...[
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value:
                    0.5, // Anda bisa mengganti dengan nilai progress yang sesungguhnya
                backgroundColor: Colors.grey.shade200,
                color: _getStatusColor(task.status, context),
                borderRadius: BorderRadius.circular(2),
                minHeight: 3,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
