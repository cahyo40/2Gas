import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';

class HomeTaskSummaryScreen extends GetView<HomeController> {
  const HomeTaskSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Text('HomeTaskSummaryScreen is working'),
    );
  }
}
