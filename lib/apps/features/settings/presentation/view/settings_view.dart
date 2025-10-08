import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:yo_ui/yo_ui_base.dart';

import '../controller/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(title: Text('SettingsView'.tr), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            YoButton.ghost(
              text: "sign out",
              onPressed: () async {
                YoConfirmDialog.show(
                  context: context,
                  title: "Logout",
                  content: "oke gan",
                  confirmText: "Gas",
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
