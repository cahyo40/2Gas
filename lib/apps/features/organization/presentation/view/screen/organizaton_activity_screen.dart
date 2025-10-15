import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/widget/card_activity_widget.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/organization_controller.dart';

class OrganizatonActivityScreen extends GetView<OrganizationController> {
  const OrganizatonActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ListView.builder(
          padding: YoPadding.all20,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.activity.length,
          itemBuilder: (_, i) {
            final model = controller.activity[i];
            return CardActivityWidget(model: model);
          },
        ),
      ),
    );
  }
}
