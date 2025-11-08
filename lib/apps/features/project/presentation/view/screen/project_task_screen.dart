import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/organization/presentation/controller/organization_controller.dart';
import 'package:twogass/apps/features/project/presentation/view/screen/project_task_fetch_screen.dart';
import 'package:twogass/apps/widget/card_summary_widget.dart';
import 'package:twogass/apps/widget/card_task_widget.dart';
import 'package:yo_ui/yo_ui_base.dart';

import '../../controller/project_controller.dart';

class ProjectTaskScreen extends GetView<ProjectController> {
  const ProjectTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orgColor = Get.find<OrganizationController>().org.value.color;
    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              YoText.titleMedium("${L10n.t.task} (${controller.task.length})"),
              TextButton(
                onPressed: () {
                  Get.to(OrganizatonTaskScreen());
                },
                child: YoText.bodyMedium(
                  L10n.t.see_all,
                  color: Color(orgColor ?? context.primaryColor.toARGB32()),
                ),
              ),
            ],
          ),
          Row(
            spacing: YoSpacing.md,
            children: TaskStatus.values.map((task) {
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
          controller.task.isEmpty
              ? Center(child: YoEmptyState.noData(title: L10n.t.msg_task_empty))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: controller.task.length > 3
                      ? 3
                      : controller.task.length,
                  itemBuilder: (context, index) {
                    final model = controller.task[index];
                    return CardTaskWidget(model: model);
                  },
                ),
        ],
      ),
    );
  }
}
