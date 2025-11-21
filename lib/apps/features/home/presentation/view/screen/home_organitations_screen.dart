import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/widget/card_home_org_loading_widget.dart';
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
                        border: Border.all(
                          color: context.textColor.withValues(alpha: .2),
                          width: 1,
                        ),
                        onTap: controller.addOrganization,

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
                        border: Border.all(
                          color: context.textColor.withValues(alpha: .2),
                          width: 1,
                        ),
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
          () => controller.isLoading.isTrue
              ? ListView.builder(
                  itemCount: 3,
                  itemBuilder: (_, i) {
                    return CardHomeOrgShimmer();
                  },
                )
              : controller.orgHome.isEmpty
              ? YoEmptyState.noData(
                  title: L10n.t.no_org_title,
                  description: L10n.t.no_org_desc,
                  actionText: L10n.t.add_org,
                  onAction: () => controller.addOrganization(),
                )
              : ListView.builder(
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
