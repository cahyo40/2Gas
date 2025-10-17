import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/schedule_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/widget/card_activity_widget.dart';
import 'package:twogass/apps/widget/card_summary_widget.dart';
import 'package:twogass/apps/widget/today_schedule_widget.dart';
import 'package:yo_ui/yo_ui_base.dart';

import '../../controller/organization_controller.dart';

class OrganizatonOverviewScreen extends GetView<OrganizationController> {
  const OrganizatonOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: YoPadding.all20,
        children: [
          Row(
            spacing: YoSpacing.md,
            children: [
              Container(
                height: Get.width * 0.2,
                width: Get.width * 0.2,
                decoration: BoxDecoration(
                  borderRadius: YoSpacing.borderRadiusMd,
                  color: Color(
                    controller.org.value.color ??
                        context.primaryColor.toARGB32(),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: YoText.titleLarge(
                            controller.org.value.name.capitalizeFirst!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                        YoText.titleMedium(
                          controller.org.value.inviteCode,
                          color: context.gray500,
                        ),
                      ],
                    ),
                    YoText.bodyMedium("12 Members"),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: YoSpacing.md),
          YoText.titleMedium("Today's Schedule"),
          SizedBox(height: YoSpacing.sm),
          TodayScheduleWidget(
            color: controller.org.value.color,
            source: [
              ScheduleModel(
                id: "id",
                uid: "uid",
                type: "type",
                start: DateTime.now().subtract(Duration(hours: 3)),
                end: DateTime.now(),
                creatdAt: DateTime.now(),
                title: "Meeting Harian",
              ),
              ScheduleModel(
                id: "id",
                uid: "uid",
                type: "type",
                start: DateTime.now().subtract(Duration(hours: 5)),
                end: DateTime.now(),
                creatdAt: DateTime.now(),
                title: "Meeting Harian",
              ),
            ],
          ),
          SizedBox(height: YoSpacing.md),
          YoText.titleMedium("Project Summary"),
          SizedBox(height: YoSpacing.sm),
          Obx(
            () => Row(
              spacing: YoSpacing.md,
              children: [
                Expanded(
                  child: CardSummaryWidget(
                    title: "Active",
                    value: controller.project
                        .where((test) => test.status == ProjectStatus.active)
                        .length,
                  ),
                ),
                Expanded(
                  child: CardSummaryWidget(
                    title: "Completed",
                    value: controller.project
                        .where((test) => test.status == ProjectStatus.completed)
                        .length,
                  ),
                ),
                Expanded(
                  child: CardSummaryWidget(
                    title: "Overdue",
                    value: controller.project
                        .where((test) => test.status == ProjectStatus.overdue)
                        .length,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: YoSpacing.md),
          YoText.titleMedium("Task Summary"),
          SizedBox(height: YoSpacing.sm),
          Obx(
            () => Row(
              spacing: YoSpacing.md,
              children: [
                Expanded(
                  child: CardSummaryWidget(
                    title: "To-Do",
                    value: controller.task
                        .where((test) => test.status == TaskStatus.todo)
                        .length,
                  ),
                ),
                Expanded(
                  child: CardSummaryWidget(
                    title: "Progress",
                    value: controller.task
                        .where((test) => test.status == TaskStatus.progress)
                        .length,
                  ),
                ),
                Expanded(
                  child: CardSummaryWidget(
                    title: "Done",
                    value: controller.task
                        .where((test) => test.status == TaskStatus.done)
                        .length,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: YoSpacing.md),
          YoText.titleMedium("Lastest Activity"),
          SizedBox(height: YoSpacing.sm),
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.activity.length > 3
                  ? 3
                  : controller.activity.length,
              itemBuilder: (_, i) {
                final model = controller.activity[i];
                return CardActivityWidget(model: model);
              },
            ),
          ),
        ],
      ),
    );
  }
}
