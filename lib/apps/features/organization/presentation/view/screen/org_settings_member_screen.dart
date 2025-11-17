import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/data/model/member_model.dart';
import 'package:twogass/apps/widget/card_member_org_widget.dart';
import 'package:twogass/l10n/generated/app_localizations.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/organization_controller.dart';

class OrgSettingsMemberScreen extends GetView<OrganizationController> {
  const OrgSettingsMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(t.all_members)),
      body: SafeArea(
        child: Padding(
          padding: YoPadding.all20,
          child: Column(
            spacing: context.yoSpacingMd,
            children: [
              // Di controller atau screen
              Obx(
                () => Row(
                  children: [
                    // Tombol Active Members
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: controller.isMemberPending.value == false
                              ? context.successColor
                              : Colors.transparent,
                          border: Border.all(
                            color: controller.isMemberPending.value == false
                                ? Colors.transparent
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              controller.isMemberPending.value = false;
                              controller.membersFilter();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              child: YoText.bodyMedium(
                                t.active_member,
                                align: TextAlign.center,
                                color: controller.isMemberPending.value == false
                                    ? context.colorTextBtn
                                    : Colors.grey.shade700,
                                fontWeight:
                                    controller.isMemberPending.value == false
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Tombol Pending Members
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: controller.isMemberPending.value == true
                              ? Color(context.warningColor.toARGB32())
                              : Colors.transparent,
                          border: Border.all(
                            color: controller.isMemberPending.value == true
                                ? Colors.transparent
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              controller.isMemberPending.value = true;
                              controller.membersFilter();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              child: YoText.bodyMedium(
                                t.pending_member,
                                align: TextAlign.center,
                                color: controller.isMemberPending.value == true
                                    ? context.colorTextBtn
                                    : Colors.grey.shade700,
                                fontWeight:
                                    controller.isMemberPending.value == true
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: controller.membersShow.length,
                    itemBuilder: (_, i) {
                      final member = controller.membersShow[i];
                      final isMember =
                          controller.myRole.value == MemberRole.member;
                      return CardMemberOrgWidget(
                        member: member,
                        isMember: isMember,
                        onTap:
                            controller.myRole.value != MemberRole.member &&
                                member.role != MemberRole.owner
                            ? () {
                                YoBottomSheet.show(
                                  context: context,
                                  title: "",
                                  maxHeight: 300,
                                  child: Column(
                                    spacing: YoSpacing.sm,
                                    children: [
                                      member.role == MemberRole.member
                                          ? YoListTile(
                                              title: L10n.t.make_admin,
                                              onTap: () {
                                                Get.back();
                                                controller.onChangeRoleMember(
                                                  member,
                                                  MemberRole.admin,
                                                );
                                              },
                                            )
                                          : YoListTile(
                                              title: L10n.t.demote_to_member,
                                              onTap: () {
                                                Get.back();
                                                controller.onChangeRoleMember(
                                                  member,
                                                  MemberRole.member,
                                                );
                                              },
                                            ),
                                      Visibility(
                                        visible:
                                            member.role == MemberRole.member,
                                        child: YoCard(
                                          backgroundColor: context.errorColor
                                              .withOpacity(.075),
                                          padding: EdgeInsets.zero,
                                          child: YoListTile(
                                            onTap: () {
                                              Get.back();
                                              YoAdvancedConfirmDialog.show(
                                                context: context,
                                                title: L10n
                                                    .t
                                                    .dialog_remove_member_title,
                                                content: L10n
                                                    .t
                                                    .dialog_remove_member_content,
                                                confirmText: L10n.t.yes,
                                                cancelText: L10n.t.no,
                                              ).then((confirm) {
                                                if (confirm == true &&
                                                    context.mounted) {
                                                  controller.onKickMember(
                                                    member,
                                                  );
                                                }
                                              });
                                            },
                                            title: L10n.t.remove_member,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            : null,
                        onAcceptTap: () {
                          YoConfirmDialog.show(
                            context: context,
                            title: t.dialog_acc_member_title,
                            content: t.dialog_acc_member_content,
                            confirmText: t.accept,
                            cancelText: t.decline,
                          ).then((confirm) {
                            controller.onAcceptMember(member);
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
