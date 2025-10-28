import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/widget/avatar_overlapping_widget.dart';
import 'package:twogass/apps/widget/user_listtile_widget.dart';
import 'package:yo_ui/yo_ui.dart';

class CardTaskWidget extends StatelessWidget {
  final TaskModel model;
  final void Function()? onTap;
  const CardTaskWidget({super.key, required this.model, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: YoPadding.onlyBottom12,
      child: YoCard(
        onTap: onTap,
        backgroundColor: context.backgroundColor,
        shadows: YoBoxShadow.apple(),
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
                        model.name,
                        fontWeight: FontWeight.w600,
                        maxLines: 2,
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 12,
                            color: Colors.grey.shade600,
                          ),
                          SizedBox(width: 4),
                          YoText.bodySmall(
                            YoDateFormatter.formatDate(model.deadline),
                            color: Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Priority badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getPriorityColor(model.priority).withOpacity(0.1),
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

            // Description
            if (model.description != null && model.description!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YoExpandableText(
                    text: model.description!,
                    textStyle: context.yoBodySmall.copyWith(
                      color: context.textColor.withOpacity(0.8),
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
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(model.status).withOpacity(0.1),
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
                  imagesUrl: model.assigns.map((e) => e.imageUrl).toList(),
                  width: .6,
                  avatarRadius: 12,
                  maxDisplay: 3,
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
