import 'package:get/get.dart';
import 'package:twogass/l10n/generated/app_localizations.dart';

class L10n {
  L10n._();
  static AppLocalizations get t {
    return AppLocalizations.of(Get.context!)!;
  }
}
