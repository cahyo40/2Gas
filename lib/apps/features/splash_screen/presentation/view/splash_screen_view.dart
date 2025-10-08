import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('SplashScreenView'.tr),
          centerTitle: true,
        ),
        body: const SafeArea(
          child: Text(
            'SplashScreenView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
