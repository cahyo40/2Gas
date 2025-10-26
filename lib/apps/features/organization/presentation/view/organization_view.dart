import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:yo_ui/yo_ui.dart';

import '../controller/organization_controller.dart';

class OrganizationView extends GetView<OrganizationController> {
  const OrganizationView({super.key});

  @override
  Widget build(BuildContext context) {
    List<BottomBarItem> listBottomNavBarItem = [
      BottomBarItem(
        title: YoText.bodyMedium("Overview"),
        icon: Icon(Iconsax.element_4_outline),
        selectedColor: Color(controller.colorIcon.value),
      ),
      BottomBarItem(
        title: YoText.bodyMedium("Project"),
        icon: Icon(Iconsax.folder_open_outline),
        selectedColor: Color(controller.colorIcon.value),
      ),
      BottomBarItem(
        title: YoText.bodyMedium("Schedule"),
        icon: Icon(Iconsax.calendar_2_outline),
        selectedColor: Color(controller.colorIcon.value),
      ),
      BottomBarItem(
        title: YoText.bodyMedium("Activity"),
        icon: Icon(Iconsax.activity_outline),
        selectedColor: Color(controller.colorIcon.value),
      ),
      BottomBarItem(
        title: YoText.bodyMedium(tr.nav_settings),
        icon: Icon(Iconsax.setting_2_outline),
        selectedColor: Color(controller.colorIcon.value),
      ),
    ];
    return RefreshIndicator(
      onRefresh: () async {
        controller.initOrg(controller.orgId.value, useLoading: false);
      },
      child: Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: Obx(
          () => controller.isLoading.isFalse
              ? StylishBottomBar(
                  option: BubbleBarOptions(barStyle: BubbleBarStyle.horizontal),
                  backgroundColor: context.backgroundColor,
                  currentIndex: controller.initialTab.value,
                  onTap: (i) => controller.changeTab(i),
                  items: listBottomNavBarItem.map((b) {
                    return b;
                  }).toList(),
                )
              : SizedBox.shrink(),
        ),
        body: SafeArea(
          child: Obx(
            () => controller.isLoading.isFalse
                ? IndexedStack(
                    index: controller.initialTab.value,
                    children: controller.tabView,
                  )
                : Center(child: YoLoading()),
          ),
        ),
      ),
    );
  }
}
