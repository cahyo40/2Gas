import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/data/model/schedule_model.dart';
import 'package:twogass/apps/widget/card_schedule_widget.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/home_controller.dart';

class HomeScheduleScreen extends GetView<HomeController> {
  const HomeScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            YoText.titleLarge("Jadwal hari ini (3)"),
            TextButton(
              onPressed: () {},
              child: YoText.bodyMedium(
                "Lihat semua jadwal",
                color: context.primaryColor,
              ),
            ),
          ],
        ),
        Column(
          children: [
            CardScheduleWidget(
              model: ScheduleModel(
                id: "id",
                uid: "uid",
                type: "private",
                date: DateTime.now().subtract(Duration(hours: 30)),
                creatdAt: DateTime.now(),
                title: "Testing Pribadi",
                description: "lorem ipsum buat pribadi",
              ),
            ),
            CardScheduleWidget(
              model: ScheduleModel(
                id: "id",
                uid: "uid",
                type: "private",
                date: DateTime.now().subtract(Duration(hours: 50)),
                creatdAt: DateTime.now(),
                title: "Testing Pribadi",
                description: "lorem ipsum buat pribadi",
              ),
              showDate: false,
            ),
            CardScheduleWidget(
              model: ScheduleModel(
                id: "id",
                uid: "uid",
                type: "org",
                orgId: YoIdGenerator.uuid(),
                date: DateTime.now(),
                creatdAt: DateTime.now(),
                title: "Testing Organisasi",
                description: "Lorem ipsum buat organisasi",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
