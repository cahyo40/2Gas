import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/features/organization/presentation/view/screen/org_settings_member_screen.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/organization_controller.dart';

class OrganizatonSettingsScreen extends GetView<OrganizationController> {
  const OrganizatonSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: YoPadding.all20,
        child: Column(
          children: [
            ListTile(
              title: YoText("Member"),
              leading: Icon(Iconsax.profile_2user_outline),
              onTap: () {
                controller.membersFilter();
                Get.to(() => OrgSettingsMemberScreen());
              },
            ),
            Spacer(),
            ListTile(
              title: YoText("Back to home"),
              leading: Icon(Iconsax.home_1_outline),
              onTap: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }
}
