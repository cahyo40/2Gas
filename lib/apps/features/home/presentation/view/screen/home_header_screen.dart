import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/core/helpers/date_helpers.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/home_controller.dart';

AuthController get user => Get.find<AuthController>();

class HomeHeaderScreen extends GetView<HomeController> {
  const HomeHeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: YoPadding.onlyBottom16,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YoText.titleLarge(YoDateFormatter().greeting(context)),
                YoText.titleMedium(
                  user.name == "" ? "" : user.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
                YoText.bodySmall(user.email),
              ],
            ),
          ),
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(user.photoUrl),
            backgroundColor: context.primaryColor,
          ),
        ],
      ),
    );
  }
}
