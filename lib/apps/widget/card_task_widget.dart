import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/widget/avatar_overlapping_widget.dart';
import 'package:twogass/apps/widget/user_listtile_widget.dart';
import 'package:yo_ui/yo_ui.dart';

class CardTaskWidget extends StatelessWidget {
  final TaskModel model;
  final void Function()? onTap;
  final void Function()? onLongPress;
  const CardTaskWidget({
    super.key,
    required this.model,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final daysLeft = model.deadline.difference(DateTime.now()).inDays;
    final isOverdue = daysLeft < 0;
    final isUrgent = daysLeft <= 3 && daysLeft >= 0;
    final isNotDone = model.status != TaskStatus.done;

    return Padding(
      padding: YoPadding.onlyBottom12,
      child: InkWell(
        onLongPress: onLongPress,
        child: Stack(
          children: [
            YoCard(
              onTap: onTap,
              backgroundColor: context.backgroundColor,
              shadows: YoBoxShadow.apple(color: context.textColor),
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header dengan deadline dan priority
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            YoText.titleMedium(
                              model.name.capitalize!,
                              fontWeight: FontWeight.w600,
                              maxLines: 2,
                            ),
                            SizedBox(height: 4),
                            if (isNotDone) // Hanya tampilkan deadline jika status bukan done
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    size: 12,
                                    color: _getDeadlineColor(daysLeft),
                                  ),
                                  SizedBox(width: 4),
                                  YoText.bodySmall(
                                    "${YoDateFormatter.formatDate(model.deadline)} (${YoDateFormatter.daysBetween(DateTime.now(), model.deadline)} Days)",
                                    color: _getDeadlineColor(daysLeft),
                                    fontWeight: isOverdue || isUrgent
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      // Priority badge
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getPriorityColor(
                            model.priority,
                          ).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: YoText.bodySmall(
                          model.priority.name.capitalize!,
                          color: _getPriorityColor(model.priority),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8),

                  // Deadline warning banner - hanya tampil jika status bukan done
                  if (isNotDone && (isOverdue || isUrgent))
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getDeadlineColor(daysLeft).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: _getDeadlineColor(daysLeft).withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isOverdue ? Icons.warning_amber : Icons.warning,
                            size: 14,
                            color: _getDeadlineColor(daysLeft),
                          ),
                          SizedBox(width: 6),
                          Expanded(
                            child: YoText.bodySmall(
                              isOverdue
                                  ? L10n.t.overdue_by(daysLeft.abs())
                                  : L10n.t.overdue_in(daysLeft),
                              color: _getDeadlineColor(daysLeft),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                  if (isNotDone && (isOverdue || isUrgent)) SizedBox(height: 8),

                  // Description
                  if (model.description != null &&
                      model.description!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        YoExpandableText(
                          text: model.description!,
                          textStyle: context.yoBodySmall.copyWith(
                            color: context.textColor.withValues(alpha: 0.8),
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),

                  // Created By
                  Row(
                    children: [
                      Expanded(
                        child: UserListtileWidget(
                          uid: model.createdBy,
                          size: UserListTileSize.small,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8),

                  // Footer row - Status and Assignees
                  Row(
                    children: [
                      // Status badge
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(
                            model.status,
                          ).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: YoText.bodySmall(
                          model.status.name.capitalize!,
                          color: _getStatusColor(model.status),
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Spacer(),

                      // Assignees
                      AvatarOverlappingWidget(
                        imagesUrl: model.assigns
                            .map((e) => e.imageUrl)
                            .toList(),
                        width: .6,
                        avatarRadius: 12,
                        maxDisplay: 3,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Red dot indicator for overdue tasks - hanya jika status bukan done
            if (isNotDone && isOverdue)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getDeadlineColor(int daysLeft) {
    if (daysLeft < 0) {
      return Colors.red; // Overdue
    } else if (daysLeft <= 1) {
      return Colors.red; // Due today or tomorrow
    } else if (daysLeft <= 3) {
      return Colors.orange; // Due in 2-3 days
    } else {
      return Colors.grey.shade600; // Normal
    }
  }

  Color _getStatusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.todo:
        return Colors.grey;
      case TaskStatus.progress:
        return Colors.orange;
      case TaskStatus.done:
        return Colors.green;
    }
  }

  Color _getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.low:
        return Colors.green;
      case Priority.medium:
        return Colors.orange;
      case Priority.high:
        return Colors.red;
    }
  }
}
