import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/features/home/presentation/controller/home_controller.dart';
import 'package:yo_ui/yo_ui.dart';

class OrganizationJoinScreen extends GetView<HomeController> {
  const OrganizationJoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Form(
              key: controller.key,
              child: Row(
                spacing: context.yoSpacingMd,
                children: [
                  Expanded(
                    child: YoTextFormField(
                      controller: controller.code,
                      inputType: YoInputType.search,
                      inputStyle: YoInputStyle.modern,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.onGetOrgByCode(controller.code.text);
                    },
                    icon: Icon(Iconsax.search_normal_1_outline),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => controller.isLoading.isTrue
                    ? Center(child: YoLoading())
                    : controller.orgs.isEmpty
                    ? YoEmptyState.noData()
                    : ListView.builder(
                        itemCount: controller.orgs.length,
                        itemBuilder: (_, i) {
                          final org = controller.orgs[i];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Color(
                                org.color ?? context.primaryColor.toARGB32(),
                              ),
                            ),
                            subtitle: YoText.bodySmall(org.description ?? ""),
                            title: YoText.titleMedium(org.name),
                            trailing: FutureBuilder<bool>(
                              future: controller.isJoinOrg(org.id),
                              builder: (context, asyncSnapshot) {
                                final isJoined = asyncSnapshot.data ?? false;

                                if (isJoined) {
                                  return YoText.bodyMedium(
                                    L10n.t.joined,
                                    color: context.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  );
                                } else {
                                  return YoButton.primary(
                                    text: L10n.t.join,
                                    size: YoButtonSize.small,
                                    textColor: context.onPrimaryColor,
                                    onPressed: () {
                                      controller.onJoinOrg(org.id);
                                    },
                                  );
                                }
                              },
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
