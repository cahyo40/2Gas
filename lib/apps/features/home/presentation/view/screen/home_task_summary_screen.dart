import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/widget/card_summary_widget.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/home_controller.dart';

class HomeTaskSummaryScreen extends GetView<HomeController> {
  const HomeTaskSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
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
    );
  }
}
