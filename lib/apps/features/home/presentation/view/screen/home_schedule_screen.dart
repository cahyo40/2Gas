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
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            YoText.titleLarge(L10n.t.today_schedule),
            TextButton(
              onPressed: () {},
              child: YoText.bodyMedium(
                L10n.t.see_all,
                color: context.primaryColor,
              ),
            ),
          ],
        ),
        Column(children: [
           
          ],
        ),
      ],
    );
  }
}
