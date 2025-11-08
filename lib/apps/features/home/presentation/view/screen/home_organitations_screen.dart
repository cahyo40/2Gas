import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/widget/card_home_org_widget.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/home_controller.dart';

class HomeOrganitationsScreen extends GetView<HomeController> {
  const HomeOrganitationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: YoSpacing.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            YoText.titleLarge(L10n.t.my_org),
            TextButton(
              onPressed: () {
                YoBottomSheet.show(
                  context: context,
                  title: L10n.t.create_org,
                  isScrollControlled: true,
                  maxHeight: Get.width * 0.75,
                  child: Column(
                    spacing: YoSpacing.md,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      YoCard(
                        shadows: YoBoxShadow.apple(color: context.textColor),
                        onTap: controller.addOrganization,
                        backgroundColor: context.backgroundColor,
                        child: ListTile(
                          leading: Container(
                            padding: YoPadding.all8,
                            decoration: BoxDecoration(
                              borderRadius: YoSpacing.borderRadiusMd,
                              color: context.secondaryColor,
                            ),
                            child: Icon(
                              Iconsax.card_add_outline,
                              color: context.backgroundColor,
                            ),
                          ),
                          title: YoText.titleMedium(L10n.t.add_org),
                        ),
                      ),
                      YoCard(
                        backgroundColor: context.backgroundColor,
                        onTap: controller.joinOrganization,
                        child: ListTile(
                          leading: Container(
                            padding: YoPadding.all8,
                            decoration: BoxDecoration(
                              borderRadius: YoSpacing.borderRadiusMd,
                              color: context.secondaryColor,
                            ),
                            child: Icon(
                              Iconsax.user_add_outline,
                              color: context.backgroundColor,
                            ),
                          ),
                          title: YoText.titleMedium(L10n.t.join_org),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: YoText.bodyMedium(
                L10n.t.create_org,
                color: context.primaryColor,
              ),
            ),
          ],
        ),

        Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.orgHome.length > 3
                ? 3
                : controller.orgHome.length,
            itemBuilder: (_, index) {
              final model = controller.orgHome[index];
              return CardHomeOrgWidget(
                model: model,
                onTap: () => controller.detailOrganization(model.org.id),
              );
            },
          ),
        ),
      ],
    );
  }
}
