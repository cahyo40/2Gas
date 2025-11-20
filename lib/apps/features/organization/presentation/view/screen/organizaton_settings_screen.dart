import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/data/model/member_model.dart';
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
                leading: YoAvatar.icon(
                  icon: Iconsax.profile_2user_outline,
                  backgroundColor: context.cardColor,
                ),
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

            Visibility(
              visible: controller.myRole.value == MemberRole.owner,
              child: YoListTile(
                title: L10n.t.delete_organization,
                leading: YoAvatar.icon(
                  icon: Iconsax.trash_outline,
                  backgroundColor: context.errorColor,
                  iconColor: context.onPrimaryColor,
                ),
                onTap: () {
                  YoAdvancedConfirmDialog.show(
                    context: context,
                    title: L10n.t.dialog_delete_org_title,
                    content: L10n.t.dialog_delete_org_content,
                    confirmText: L10n.t.yes,
                    confirmVariant: YoButtonVariant.custom,
                    confirmColor: context.primaryColor,
                    cancelText: L10n.t.no,
                  ).then((confirm) {
                    if (confirm == true && context.mounted) {
                      controller.onDeleteOrg();
                    }
                  });
                },
              ),
            ),
            Spacer(),
            ListTile(
              title: YoText(L10n.t.back_to_home),
              leading: YoAvatar.icon(
                icon: Iconsax.home_1_outline,
                backgroundColor: context.cardColor,
              ),
              onTap: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }
}
