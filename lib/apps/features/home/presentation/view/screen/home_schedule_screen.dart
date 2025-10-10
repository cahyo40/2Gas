import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';

class HomeScheduleScreen extends GetView<HomeController> {
  const HomeScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Text('HomeScheduleScreen is working'),
    );
  }
}
