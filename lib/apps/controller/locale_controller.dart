import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/core/services/storage.dart';

class LocaleController extends GetxController {
  Locale get locale {
    final code = StorageService.locale.split('_');
    return Locale(code[0], code.length > 1 ? code[1] : null);
  }

  void change(String newLocale) async {
    await StorageService.saveLocale(newLocale);
    Get.updateLocale(_parse(newLocale));
    update();
  }

  Locale _parse(String code) {
    final split = code.split('_');
    return Locale(split[0], split.length > 1 ? split[1] : null);
  }
}
