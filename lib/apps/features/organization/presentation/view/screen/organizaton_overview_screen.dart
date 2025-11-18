import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/widget/card_activity_widget.dart';
import 'package:twogass/apps/widget/card_summary_widget.dart';
import 'package:twogass/apps/widget/today_schedule_widget.dart';
import 'package:twogass/l10n/generated/app_localizations.dart';
import 'package:yo_ui/yo_ui_base.dart';

import '../../controller/organization_controller.dart';

class OrganizatonOverviewScreen extends GetView<OrganizationController> {
  const OrganizatonOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final orgColor = Color(
      controller.org.value.color ?? context.primaryColor.toARGB32(),
    );
    return SafeArea(
      child: ListView(
        padding: YoPadding.all20,
        children: [
          Row(
            spacing: YoSpacing.md,
            children: [
              Container(
                width: context.width * 0.2,
                height: context.width * 0.2,
                decoration: BoxDecoration(
                  color: orgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: YoText.displayMedium(
                    controller.org.value.name.substring(0, 1).toUpperCase(),
                    color: context.onPrimaryColor,
                    fontWeight: FontWeight.w700,
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
                            controller.org.value.name,
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
                    YoText.bodyMedium(
                      "${controller.members.where((v) => v.isPending == false).toList().length} ${t.member}",
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: YoSpacing.md),
          YoText.titleMedium(t.today_schedule),
          SizedBox(height: YoSpacing.sm),
          TodayScheduleWidget(color: controller.org.value.color, source: [
             
            ],
          ),
          SizedBox(height: YoSpacing.md),
          YoText.titleMedium(t.project_summary),
          SizedBox(height: YoSpacing.sm),
          Obx(
            () => Row(
              spacing: YoSpacing.md,
              children: [
                Expanded(
                  child: CardSummaryWidget(
                    title: t.active,
                    value: controller.project
                        .where((test) => test.status == ProjectStatus.active)
                        .length,
                  ),
                ),
                Expanded(
                  child: CardSummaryWidget(
                    title: t.completed,
                    value: controller.project
                        .where((test) => test.status == ProjectStatus.completed)
                        .length,
                  ),
                ),
                Expanded(
                  child: CardSummaryWidget(
                    title: t.overdue,
                    value: controller.project
                        .where((test) => test.status == ProjectStatus.overdue)
                        .length,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: YoSpacing.md),
          YoText.titleMedium(t.task_summary),
          SizedBox(height: YoSpacing.sm),
          Row(
            spacing: YoSpacing.md,
            children: TaskStatus.values.where((e) => e != TaskStatus.all).map((
              task,
            ) {
              return Expanded(
                child: CardSummaryWidget(
                  title: task.name.capitalize!,
                  value: controller.task
                      .where((d) => d.status.name == task.name)
                      .toList()
                      .length,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: YoSpacing.md),
          YoText.titleMedium(t.latest_activity),
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
