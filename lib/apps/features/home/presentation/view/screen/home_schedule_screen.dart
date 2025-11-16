import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/home_controller.dart';

class HomeScheduleScreen extends GetView<HomeController> {
  const HomeScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: context.yoSpacingMd,
      children: [
        YoText.titleLarge(L10n.t.today_schedule),
        Obx(
          () => controller.scheduleShow.isEmpty
              ? YoEmptyState.noData()
              : YoTimeline(
                  events: controller.scheduleShow.map((schedule) {
                    return YoTimelineEvent(
                      title: schedule.title,
                      date: schedule.date,

                      description: schedule.description,
                    );
                  }).toList(),
                ),
        ),
      ],
    );
  }
}
