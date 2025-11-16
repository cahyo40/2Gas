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
    return RefreshIndicator(
      onRefresh: () async {
        await controller.initOrg();
      },
      child: Scaffold(
        body: Obx(
          () => controller.isLoading.isTrue
              ? Center(child: YoLoading())
              : SafeArea(
                  child: ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: YoPadding.all20,
                    children: [
                      HomeHeaderScreen(),
                      SizedBox(height: YoSpacing.md),
                      HomeScheduleScreen(),
                      SizedBox(height: YoSpacing.md),
                      HomeTaskSummaryScreen(),
                      SizedBox(height: YoSpacing.md),
                      HomeOrganitationsScreen(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
