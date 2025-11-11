import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/controller/locale_controller.dart';
import 'package:twogass/apps/controller/theme_controller.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:yo_ui/yo_ui_base.dart';

import '../controller/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    final theme = Get.find<ThemeController>();
    final locale = Get.find<LocaleController>();
    return Scaffold(
      appBar: AppBar(title: Text('SettingsView'.tr), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            Obx(
              () => YoListTile(
                title: L10n.t.theme,
                trailing: YoText.bodyMedium(
                  theme.isDarkMode.isTrue
                      ? L10n.t.dark_mode
                      : L10n.t.light_mode,
                ),
                onTap: () {
                  theme.toggle();
                },
              ),
            ),
            Obx(
              () => YoListTile(
                title: L10n.t.language,

                trailing: YoText.bodyMedium(
                  locale.isIndonesia ? "Indonesia" : "English",
                ),
                onTap: () {
                  locale.toggle();
                },
              ),
            ),
            Spacer(),
            YoListTile(
              title: L10n.t.logout,
              leading: Icon(Iconsax.logout_outline),
              onTap: () {
                YoAdvancedConfirmDialog.show(
                  context: context,
                  title: L10n.t.msg_logout_title,
                  content: L10n.t.msg_logout_content,
                  confirmText: L10n.t.accept,
                  cancelText: L10n.t.decline,
                  confirmVariant: YoButtonVariant.primary,
                  cancelVariant: YoButtonVariant.outline,
                ).then((confirm) async {
                  if (confirm == true) {
                    await auth.signOut();
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
