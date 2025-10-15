import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/core/helpers/activity_message.dart';
import 'package:twogass/apps/data/model/activity_model.dart';
import 'package:twogass/apps/widget/card_activity_widget.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/organization_controller.dart';

class OrganizatonActivityScreen extends GetView<OrganizationController> {
  const OrganizatonActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: YoPadding.all20,
        children: [
          CardActivityWidget(
            model: ActivityModel.initial().copyWith(
              title: "Created Organization",
              description: ActivityMessageHelper.getActivityMessage(
                context,
                ActivityType.organizationCreated,
                ActivityMeta(organizationName: "Dhuwitku", memberName: "Cahyo"),
              ),
            ),
          ),
          CardActivityWidget(
            model: ActivityModel.initial().copyWith(
              title: "Comment at",
              type: ActivityType.commentAdded,
              description: ActivityMessageHelper.getActivityMessage(
                context,
                ActivityType.commentAdded,
                ActivityMeta(memberName: "Cahyo"),
              ),
            ),
          ),
          CardActivityWidget(
            model: ActivityModel.initial().copyWith(
              title: "Comment at",
              type: ActivityType.taskCommented,
              description: ActivityMessageHelper.getActivityMessage(
                context,
                ActivityType.taskCommented,
                ActivityMeta(memberName: "Cahyo", taskName: "Kosong"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
