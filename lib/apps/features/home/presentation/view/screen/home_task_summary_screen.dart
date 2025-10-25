import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/home_controller.dart';

class HomeTaskSummaryScreen extends GetView<HomeController> {
  const HomeTaskSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        spacing: YoSpacing.md,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YoText.titleLarge('Task Summary'),
          Row(
            spacing: YoSpacing.md,
            children: [
              Expanded(child: _cardHomeSummary("To-Do", 90)),
              Expanded(child: _cardHomeSummary("Progress", 120)),
              Expanded(child: _cardHomeSummary("Done", 90)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cardHomeSummary(String title, double value) {
    return YoCard(
      backgroundColor: Get.context!.backgroundColor,
      shadows: YoBoxShadow.apple(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          YoText.bodyMedium(title),
          YoText.monoLarge(value.toStringAsFixed(0), fontSize: YoSpacing.xl),
        ],
      ),
    );
  }
}
