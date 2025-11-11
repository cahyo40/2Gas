import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/core/services/storage.dart';

class LocaleController extends GetxController {
  /* ---------- konstanta ---------- */
  static const String _en = 'en';
  static const String _id = 'id_ID';

  /* ---------- observable ---------- */
  final lang = const Locale(_en).obs;

  /* ---------- getter ---------- */
  Locale get locale => lang.value;
  bool get isIndonesia => lang.value.languageCode == 'id';

  /* ---------- life-cycle ---------- */
  @override
  void onInit() {
    _loadSaved();
    super.onInit();
  }

  /* ---------- privat ---------- */
  void _loadSaved() {
    final code = StorageService.locale; // baca storage
    lang.value = _parse(code);
    Get.updateLocale(lang.value);
  }

  Locale _parse(String code) {
    final split = code.split('_');
    return Locale(split[0], split.length > 1 ? split[1] : null);
  }

  /* ---------- toggle ---------- */
  Future<void> toggle() async {
    final newLocale = isIndonesia ? _en : _id;
    await StorageService.saveLocale(newLocale);
    lang.value = _parse(newLocale);
    Get.updateLocale(lang.value);
  }
}
