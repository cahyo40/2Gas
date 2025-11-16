import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
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
            Obx(
              () => YoListTile(
                title: L10n.t.member,
                leading: Icon(Iconsax.profile_2user_outline),
                onTap: () {
                  controller.membersFilter();
                  Get.to(() => OrgSettingsMemberScreen());
                },
                trailing: Visibility(
                  visible: controller.members
                      .where((e) => e.isPending == true)
                      .isNotEmpty,
                  child: YoText.bodyMedium(
                    "${controller.members.where((e) => e.isPending == true).length} Member pending",
                  ),
                ),
              ),
            ),
            Spacer(),
            ListTile(
              title: YoText(L10n.t.back_to_home),
              leading: Icon(Iconsax.home_1_outline),
              onTap: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }
}
