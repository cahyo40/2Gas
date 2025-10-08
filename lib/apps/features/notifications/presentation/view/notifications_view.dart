import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('NotificationsView'.tr),
          centerTitle: true,
        ),
        body: const SafeArea(
          child: Text(
            'NotificationsView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
