import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/widget/card_notif_user_widget.dart';
import 'package:yo_ui/yo_ui.dart';

import '../controller/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(L10n.t.nav_notif), centerTitle: true),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => controller.isLoading.isTrue
                      ? Center(child: YoLoading())
                      : controller.notificationShow.isEmpty
                      ? YoEmptyState.noData()
                      : ListView.builder(
                          padding: YoPadding.all20,
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: controller.notificationShow.length,
                          itemBuilder: (_, index) {
                            final notif = controller.notificationShow[index];
                            return CardNotifUserWidget(notif: notif);
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
