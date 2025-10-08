import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/core/constants/images.dart';
import 'package:twogass/l10n/generated/app_localizations.dart';
import 'package:yo_ui/yo_ui.dart';

import '../controller/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // controller.getVersion();
    final auth = Get.find<AuthController>();
    final tr = AppLocalizations.of(context)!;
    YoLogger.info(controller.version.value);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: YoPadding.all20,
          child: Column(
            spacing: YoSpacing.sm,
            children: [
              SizedBox(
                height: Get.width,
                width: double.infinity,
                child: YoImage.asset(assetPath: Images.login),
              ),
              Spacer(),
              YoText.headlineMedium(
                tr.login_title,
                align: TextAlign.center,
                fontWeight: FontWeight.bold,
              ),
              YoText.bodyMedium(tr.login_subtitle),
              SizedBox(height: YoSpacing.md),
              YoButton.primary(
                text: tr.login_button_google,
                onPressed: () async {
                  await auth.signInWithGoogle();
                },
                icon: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 16,
                  child: Brand(Brands.google, size: 24),
                ),
              ),
              Spacer(),
              YoText.monoMedium("yo_dev"),
              YoText.bodySmall("Version ${controller.version.value}"),
            ],
          ),
        ),
      ),
    );
  }
}
