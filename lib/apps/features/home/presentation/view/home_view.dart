import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/features/home/presentation/view/screen/home_header_screen.dart';
import 'package:twogass/apps/features/home/presentation/view/screen/home_organitations_screen.dart';
import 'package:twogass/apps/features/home/presentation/view/screen/home_schedule_screen.dart';
import 'package:twogass/apps/features/home/presentation/view/screen/home_task_summary_screen.dart';
import 'package:yo_ui/yo_ui.dart';

import '../controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: YoPadding.all20,
          children: [
            HomeHeaderScreen(),
            HomeScheduleScreen(),
            HomeTaskSummaryScreen(),
            HomeOrganitationsScreen(),
          ],
        ),
      ),
    );
  }
}
