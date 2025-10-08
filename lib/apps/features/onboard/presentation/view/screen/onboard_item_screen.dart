import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/data/model/onboard.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/onboard_controller.dart';

class OnboardItemScreen extends GetView<OnboardController> {
  final OnboardModel model;
  const OnboardItemScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          YoImage.asset(assetPath: model.image),
          const SizedBox(height: 32),
          YoText.headlineMedium(
            model.title,
            align: TextAlign.center,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 16),
          YoText.bodyLarge(model.desc, align: TextAlign.center),
        ],
      ),
    );
  }
}
