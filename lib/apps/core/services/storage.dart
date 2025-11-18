import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:twogass/apps/core/constants/storage.dart';

class StorageService {
  static final box = GetStorage();

  // Tema
  static bool get isDark => box.read(StorageConst.isDark) ?? false;
  static Future<void> saveTheme(bool val) =>
      box.write(StorageConst.isDark, val);

  // Bahasa
  static String get locale => box.read(StorageConst.locale) ?? 'id_ID';
  static Future<void> saveLocale(String val) =>
      box.write(StorageConst.locale, val);

  static Future<void> saveUser(User user, String? playerId) async {
    box.write(StorageConst.uid, user.uid);
    box.write(StorageConst.name, user.displayName ?? "");
    box.write(StorageConst.emaill, user.email ?? "");
    box.write(StorageConst.photo, user.photoURL ?? "");
    box.write(StorageConst.player, playerId ?? "");
  }

  static Future<void> clearUser() async {
    box.write(StorageConst.uid, "");
    box.write(StorageConst.name, "");
    box.write(StorageConst.emaill, "");
    box.write(StorageConst.photo, "");
    box.write(StorageConst.player, "");
  }
}
