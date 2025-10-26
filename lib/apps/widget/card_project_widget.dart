import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/core/services/firebase.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/widget/avatar_overlapping_widget.dart';
import 'package:twogass/apps/widget/priority_widget.dart';
import 'package:yo_ui/yo_ui.dart';

class CardProjectWidget extends StatelessWidget {
  final ProjectModel model;
  final void Function()? onTap;
  const CardProjectWidget({super.key, required this.model, this.onTap});

  @override
  Widget build(BuildContext context) {
    Future<double> getPercentage() async {
      final data = await FirebaseServices.task
          .where("orgId", isEqualTo: model.orgId)
          .where("projectId", isEqualTo: model.id)
          .get();
      final dataAll = data.docs.length;
      final dataDone = data.docs
          .map((e) => TaskModel.fromFirestore(e))
          .toList()
          .where((e) => e.status == TaskStatus.done)
          .length;
      if (dataAll == 0) {
        return 0.0;
      } else {
        return dataDone / dataAll;
      }
    }

    Future<int> getTaskCount() async {
      final data = await FirebaseServices.task
          .where("orgId", isEqualTo: model.orgId)
          .where("projectId", isEqualTo: model.id)
          .get();
      return data.docs.length;
    }

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
            // Header row
            Row(
              children: [
                Expanded(
                  child: YoText.titleMedium(
                    model.name,
                    fontWeight: FontWeight.w600,
                    maxLines: 1,
                  ),
                ),
                SizedBox(width: 8),
                PriorityWidget(priority: model.priority),
              ],
            ),

            SizedBox(height: 8),

            // Progress and info in one row
            Row(
              children: [
                // Progress section
                Expanded(
                  flex: 3,
                  child: FutureBuilder<double>(
                    future: getPercentage(),
                    initialData: 0.0,
                    builder: (context, asyncSnapshot) {
                      final percent = asyncSnapshot.data ?? 0.0;
                      final percentText = (percent * 100).toStringAsFixed(0);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              YoText.bodySmall(
                                "Progress",
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(width: 4),
                              YoText.bodySmall(
                                "$percentText%",
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(2),
                            minHeight: 4,
                            backgroundColor: context.primaryColor.withOpacity(
                              0.1,
                            ),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              context.primaryColor,
                            ),
                            value: percent,
                          ),
                        ],
                      );
                    },
                  ),
                ),

                SizedBox(width: 16),

                // Tasks count
                Expanded(
                  flex: 2,
                  child: FutureBuilder<int>(
                    future: getTaskCount(),
                    initialData: 0,
                    builder: (context, snapshot) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        YoText.bodySmall("Tasks", fontWeight: FontWeight.w500),
                        SizedBox(height: 2),
                        YoText.titleSmall(
                          "${snapshot.data ?? 0}",
                          fontWeight: FontWeight.w700,
                          color: context.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 8),

            // Footer row
            Row(
              children: [
                // Status
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getStatusColor(model.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: YoText.bodySmall(
                    model.status.name.capitalize!,
                    color: _getStatusColor(model.status),
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(width: 8),

                // Due date
                Icon(
                  Icons.calendar_today_outlined,
                  size: 12,
                  color: Colors.grey.shade600,
                ),
                SizedBox(width: 2),
                YoText.bodySmall(
                  YoDateFormatter.formatDate(model.deadline),
                  color: Colors.grey.shade600,
                ),

                Spacer(),

                // Members
                AvatarOverlappingWidget(
                  imagesUrl: model.assign.map((e) => e.imageUrl).toList(),
                  width: .5,
                  avatarRadius: 10,
                  maxDisplay: 3,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.active:
        return Get.context!.infoColor;
      case ProjectStatus.completed:
        return Get.context!.successColor;
      case ProjectStatus.overdue:
        return Get.context!.warningColor;
    }
  }
}
