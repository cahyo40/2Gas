import 'package:get/get.dart';
import 'package:twogass/apps/controller/locale_controller.dart';
import 'package:twogass/apps/controller/theme_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController(), permanent: true);
    Get.put(LocaleController(), permanent: true);
  }
}
