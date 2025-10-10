import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';

class HomeHeaderScreen extends GetView<HomeController> {
  const HomeHeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Text('HomeHeaderScreen is working'),
    );
  }
}
