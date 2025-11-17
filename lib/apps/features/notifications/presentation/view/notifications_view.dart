import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/widget/card_notif_user_shimmer_widget.dart';
import 'package:twogass/apps/widget/card_notif_user_widget.dart';
import 'package:yo_ui/yo_ui.dart';

import '../controller/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.initData();
      },
      child: Scaffold(
        appBar: AppBar(title: Text(L10n.t.nav_notif), centerTitle: true),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => controller.notificationShow.isEmpty
                      ? YoEmptyState.noData(
                          title: L10n.t.no_notif_title,
                          description: L10n.t.no_notif_desc,
                          actionText: L10n.t.refresh,
                          onAction: () => controller.initData(useLoading: true),
                        )
                      : ListView.builder(
                          padding: YoPadding.all20,
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: controller.notificationShow.length,
                          itemBuilder: (_, index) {
                            final notif = controller.notificationShow[index];
                            if (controller.isLoading.isTrue) {
                              return CardNotifUserShimmer();
                            } else {
                              return CardNotifUserWidget(notif: notif);
                            }
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
