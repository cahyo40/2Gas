import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/core/services/storage.dart';

class ThemeController extends GetxController {
  bool get isDark => StorageService.isDark;

  ThemeMode get themeMode => isDark ? ThemeMode.dark : ThemeMode.light;
  void toggle() async {
    await StorageService.saveTheme(!isDark);
    Get.changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
    update();
  }
}
