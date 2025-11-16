import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/features/organization/presentation/controller/organization_controller.dart';
import 'package:twogass/apps/features/task_create/presentation/view/screen/field_assigns_task_screen.dart';
import 'package:twogass/apps/features/task_create/presentation/view/screen/field_deadline_task_screen.dart';
import 'package:twogass/apps/features/task_create/presentation/view/screen/field_desc_task_screen.dart';
import 'package:twogass/apps/features/task_create/presentation/view/screen/field_priority_task_screen.dart';
import 'package:twogass/apps/features/task_create/presentation/view/screen/field_title_task_screen.dart';
import 'package:yo_ui/yo_ui_base.dart';

import '../controller/task_create_controller.dart';

class TaskCreateView extends GetView<TaskCreateController> {
  const TaskCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    final org = Get.find<OrganizationController>();
    return Scaffold(
      appBar: YoAppBar(
        title: L10n.t.create_task,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back(result: false);
          },
          icon: Icon(Iconsax.arrow_left_2_outline),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: controller.form,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: YoPadding.all20,
            children: [
              FieldTitleTaskScreen(),
              FieldDescTaskScreen(),
              FieldDeadlineTaskScreen(),
              FieldPriorityTaskScreen(),
              FieldAssignsTaskScreen(),
              YoButton.custom(
                size: YoButtonSize.medium,
                text: L10n.t.submit,
                onPressed: () {
                  controller.onSubmit();
                },
                textColor: context.onPrimaryColor,
                backgroundColor: Color(
                  org.org.value.color ?? context.primaryColor.toARGB32(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
