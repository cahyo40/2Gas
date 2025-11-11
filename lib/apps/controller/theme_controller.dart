import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/core/services/storage.dart';
import 'package:yo_ui/yo_ui.dart';

class ThemeController extends GetxController {
  bool get isDark => StorageService.isDark;

  RxBool isDarkMode = false.obs;

  ThemeMode get themeMode => isDark ? ThemeMode.dark : ThemeMode.light;
  void toggle() async {
    final newValue = !isDark; // hitung sekali
    await StorageService.saveTheme(newValue); // simpan
    isDarkMode.value = newValue; // update Rx
    Get.changeThemeMode(newValue ? ThemeMode.dark : ThemeMode.light);
    YoLogger.debug('theme changed to: ${newValue ? 'dark' : 'light'}');
  }

  @override
  void onInit() {
    isDarkMode.value = isDark;
    super.onInit();
  }
}
