import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/widget/card_task_widget.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/organization_controller.dart';

class OrganizatonTaskScreen extends GetView<OrganizationController> {
  const OrganizatonTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: YoPadding.all20,
        children: [
          Row(
            spacing: YoSpacing.md,
            children: [
              Expanded(
                child: TextFormField(
                  style: context.yoBodyMedium,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: "Search Task",
                    hintStyle: context.yoBodyMedium.copyWith(
                      color: context.gray500,
                    ),
                    prefixIcon: Icon(Iconsax.search_normal_1_outline),
                    suffix: InkWell(
                      onTap: () {},
                      child: Icon(
                        Iconsax.close_circle_outline,
                        color: context.errorColor,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(onPressed: () {}, icon: Icon(Iconsax.filter_outline)),
            ],
          ),
          SizedBox(height: YoSpacing.md),
          Obx(
            () => Wrap(
              spacing: 8,
              children: List.generate(
                controller.filtersTask.length,
                (i) => ChoiceChip(
                  label: YoText.bodyMedium(
                    controller.filtersTask[i],
                    color: controller.currentFilterTask.value == i
                        ? context.colorTextBtn
                        : context.textColor,
                  ),
                  checkmarkColor: context.colorTextBtn,
                  selected: controller.currentFilterTask.value == i,
                  onSelected: (_) => controller.changeFilterTask(i),
                ),
              ),
            ),
          ),
          CardTaskWidget(
            model: TaskModel(
              id: "id",
              projectId: "projectId",
              orgId: "orgId",
              name: "Task name",
              priority: "priority",
              deadline: DateTime.now().add(Duration(days: 4, minutes: 40)),
              createdAt: DateTime.now(),
              createdBy: "createdBy",
              assigns: [],
            ),
          ),
        ],
      ),
    );
  }
}
