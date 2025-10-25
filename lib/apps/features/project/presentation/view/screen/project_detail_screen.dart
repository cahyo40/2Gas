import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/core/helpers/color_helpers.dart';
import 'package:twogass/apps/core/helpers/priority_message.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/project_controller.dart';

class ProjectDetailScreen extends GetView<ProjectController> {
  const ProjectDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = controller.project.value;
    return SafeArea(
      child: Column(
        spacing: YoSpacing.sm,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(flex: 3, child: YoText.titleMedium("Status")),
              YoText(": "),
              Expanded(
                flex: 7,
                child: YoText.bodyMedium(model.status.name.capitalize!),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(flex: 3, child: YoText.titleMedium("Priority")),
              YoText(": "),
              Expanded(
                flex: 7,
                child: YoText.bodyMedium(
                  PriorityMessage().call(context, model.priority),
                  fontWeight: FontWeight.bold,
                  color: YoColors().getPriority(context, model.priority),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(flex: 3, child: YoText.titleMedium("Deadline")),
              YoText(": "),
              Expanded(
                flex: 7,
                child: YoText(
                  "${YoDateFormatter.formatDate(model.deadline)} (${YoDateFormatter.daysBetween(DateTime.now(), model.deadline)} Hari lagi)",
                ),
              ),
            ],
          ),
          model.categories.isNotEmpty
              ? Row(
                  children: [
                    Expanded(flex: 3, child: YoText.titleMedium("Category")),
                    YoText(": "),
                    Expanded(
                      flex: 7,
                      child: YoText.bodyMedium(
                        model.categories.map((e) => e.name).toList().join(", "),
                      ),
                    ),
                  ],
                )
              : SizedBox.shrink(),
          Row(
            children: [
              Expanded(flex: 3, child: YoText.titleMedium("Created By")),
              YoText(": "),
              Expanded(flex: 7, child: YoText(controller.createdBy.value.name)),
            ],
          ),
          Row(
            children: [
              Expanded(flex: 3, child: YoText.titleMedium("Created At")),
              YoText(": "),
              Expanded(
                flex: 7,
                child: YoText.bodyMedium(
                  YoDateFormatter.formatDateTime(model.createdAt),
                ),
              ),
            ],
          ),
          YoText.titleMedium("Description"),
          YoExpandableText(
            text: controller.project.value.description!,
            textStyle: context.yoBodySmall.copyWith(color: context.textColor),
          ),
        ],
      ),
    );
  }
}
