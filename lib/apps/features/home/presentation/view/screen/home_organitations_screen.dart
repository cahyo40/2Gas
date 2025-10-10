import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';

class HomeOrganitationsScreen extends GetView<HomeController> {
  const HomeOrganitationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Text('HomeOrganitationsScreen is working'),
    );
  }
}
