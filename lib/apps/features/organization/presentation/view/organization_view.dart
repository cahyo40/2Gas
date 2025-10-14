import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:yo_ui/yo_ui.dart';

import '../controller/organization_controller.dart';

class OrganizationView extends GetView<OrganizationController> {
  const OrganizationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Obx(
        () => StylishBottomBar(
          option: BubbleBarOptions(barStyle: BubbleBarStyle.horizontal),
          backgroundColor: context.backgroundColor,
          currentIndex: controller.initialTab.value,
          onTap: (i) => controller.changeTab(i),
          items: controller.listBottomNavBarItem.map((b) {
            return b;
          }).toList(),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => IndexedStack(
            index: controller.initialTab.value,
            children: controller.tabView,
          ),
        ),
      ),
    );
  }
}
