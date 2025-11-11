import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:twogass/apps/features/home/presentation/view/home_view.dart';
import 'package:twogass/apps/features/notifications/presentation/view/notifications_view.dart';
import 'package:twogass/apps/features/schedule/presentation/view/schedule_view.dart';
import 'package:twogass/apps/features/settings/presentation/view/settings_view.dart';
import 'package:twogass/apps/features/task/presentation/view/task_view.dart';
import 'package:twogass/apps/widget/connectivity_widget.dart';
import 'package:twogass/l10n/generated/app_localizations.dart';
import 'package:yo_ui/yo_ui.dart';

import '../controller/bottom_navigation_bar_controller.dart';

class BottomNavigationBarView extends GetView<BottomNavigationBarController> {
  const BottomNavigationBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(Get.context!)!;
    return Scaffold(
      bottomNavigationBar: Obx(
        () => StylishBottomBar(
          option: BubbleBarOptions(barStyle: BubbleBarStyle.horizontal),
          backgroundColor: context.backgroundColor,
          currentIndex: controller.currentPage.value,
          onTap: (i) => controller.changePage(i),
          items: [
            BottomBarItem(
              title: Text(tr.nav_home),
              icon: Icon(Iconsax.home_1_outline),
              selectedColor:
                  Get.context?.primaryColor ?? Get.theme.primaryColor,
            ),
            BottomBarItem(
              title: Text(tr.nav_task),
              icon: Icon(Iconsax.task_outline),
              selectedColor:
                  Get.context?.primaryColor ?? Get.theme.primaryColor,
            ),
            BottomBarItem(
              title: Text(tr.nav_schedule),
              icon: Icon(Iconsax.calendar_2_outline),
              selectedColor:
                  Get.context?.primaryColor ?? Get.theme.primaryColor,
            ),
            BottomBarItem(
              title: Text(tr.nav_notif),
              icon: Icon(Iconsax.notification_outline),
              selectedColor:
                  Get.context?.primaryColor ?? Get.theme.primaryColor,
            ),
            BottomBarItem(
              title: Text(tr.nav_settings),
              icon: Icon(Iconsax.setting_4_outline),
              selectedColor:
                  Get.context?.primaryColor ?? Get.theme.primaryColor,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ConnectivityWidget(),
            Expanded(
              child: Obx(
                () => IndexedStack(
                  index: controller.currentPage.value,
                  children: [
                    HomeView(),
                    TaskView(),
                    ScheduleView(),
                    NotificationsView(),
                    SettingsView(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
