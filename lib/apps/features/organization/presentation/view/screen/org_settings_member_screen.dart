import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/data/model/member_model.dart';
import 'package:twogass/apps/widget/card_member_org_widget.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/organization_controller.dart';

class OrgSettingsMemberScreen extends GetView<OrganizationController> {
  const OrgSettingsMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Members")),
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
                                "Active Members",
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
                                "Pending Members",
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
                        onAcceptTap: () {
                          YoConfirmDialog.show(
                            context: context,
                            title: "Confirmation",
                            content: "Confirmation gan",
                            confirmText: "Accept",
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
