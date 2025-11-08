import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/data/model/activity_model.dart';
import 'package:twogass/apps/widget/card_activity_widget.dart';
import 'package:twogass/l10n/generated/app_localizations.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/organization_controller.dart';

class OrganizatonActivityScreen extends GetView<OrganizationController> {
  const OrganizatonActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orgColor = controller.org.value.color;
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: YoAppBar(
        title: t.activity_org,
        leading: SizedBox(),
        backgroundColor: context.backgroundColor,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: ListView.separated(
              padding: YoPadding.symmetricH12,
              scrollDirection: Axis.horizontal,
              itemCount: ActivityTypeCategory.values.length,
              separatorBuilder: (_, __) => SizedBox(width: 8),
              itemBuilder: (context, index) {
                final e = ActivityTypeCategory.values[index];

                return Obx(
                  () => YoChip(
                    borderRadius: 20,
                    backgroundColor: controller.activityFilter.value == e
                        ? Color(orgColor ?? context.primaryColor.toARGB32())
                        : context.backgroundColor,
                    label: e.name.capitalize!,
                    size: YoChipSize.large,
                    textColor: controller.activityFilter.value == e
                        ? context.onPrimaryColor
                        : context.textColor,
                    borderColor: context.gray200,
                    onTap: () {
                      controller.changeActivityFilter(e);
                    },
                  ),
                );
              },
            ),
          ),
          YoSpace.heightMd(),
          Expanded(
            child: Obx(
              () => controller.activityShow.isEmpty
                  ? SizedBox(child: Center(child: YoEmptyState.noData()))
                  : ListView.builder(
                      padding: YoPadding.all20,
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: controller.activityShow.length,
                      itemBuilder: (_, i) {
                        final model = controller.activityShow[i];

                        return CardActivityWidget(model: model);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
