import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/onboard_controller.dart';

class OnboardView extends GetView<OnboardController> {
  const OnboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('OnboardView'.tr),
          centerTitle: true,
        ),
        body: const SafeArea(
          child: Text(
            'OnboardView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
