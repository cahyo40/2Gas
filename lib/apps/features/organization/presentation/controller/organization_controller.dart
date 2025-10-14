import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:twogass/apps/features/organization/presentation/view/screen/organizaton_activity_screen.dart';
import 'package:twogass/apps/features/organization/presentation/view/screen/organizaton_overview_screen.dart';
import 'package:twogass/apps/features/organization/presentation/view/screen/organizaton_project_screen.dart';
import 'package:twogass/apps/features/organization/presentation/view/screen/organizaton_settings_screen.dart';
import 'package:twogass/apps/features/organization/presentation/view/screen/organizaton_task_screen.dart';
import 'package:twogass/l10n/generated/app_localizations.dart';
import 'package:yo_ui/yo_ui.dart';

final tr = AppLocalizations.of(Get.context!)!;

class OrganizationController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();

  final initialTab = 0.obs;
  final orgId = "".obs;

  final List<BottomBarItem> listBottomNavBarItem = [
    BottomBarItem(
      title: YoText.bodyMedium("Overview"),
      icon: Icon(Iconsax.element_4_outline),
      selectedColor: Get.context?.primaryColor ?? Get.theme.primaryColor,
    ),
    BottomBarItem(
      title: YoText.bodyMedium("Project"),
      icon: Icon(Iconsax.folder_open_outline),
      selectedColor: Get.context?.primaryColor ?? Get.theme.primaryColor,
    ),
    BottomBarItem(
      title: YoText.bodyMedium("Task"),
      icon: Icon(Iconsax.note_text_outline),
      selectedColor: Get.context?.primaryColor ?? Get.theme.primaryColor,
    ),
    BottomBarItem(
      title: YoText.bodyMedium("Activity"),
      icon: Icon(Iconsax.activity_outline),
      selectedColor: Get.context?.primaryColor ?? Get.theme.primaryColor,
    ),
    BottomBarItem(
      title: YoText.bodyMedium(tr.nav_settings),
      icon: Icon(Iconsax.setting_2_outline),
      selectedColor: Get.context?.primaryColor ?? Get.theme.primaryColor,
    ),
  ];
  final tabView = [
    OrganizatonOverviewScreen(),
    OrganizatonProjectScreen(),
    OrganizatonTaskScreen(),
    OrganizatonActivityScreen(),
    OrganizatonSettingsScreen(),
  ];

  void changeTab(int i) {
    initialTab.value = i;
  }

  @override
  void onInit() {
    final args = Get.arguments;
    if (args is Map<String, dynamic> && args['id'] != null) {
      orgId.value = args['id'] as String;
      YoLogger.info('Org ID: ${orgId.value}');
    } else {
      YoLogger.error('Argumen "id" tidak ditemukan atau null');
      // opsional: kembali atau tampilkan error
    }

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
