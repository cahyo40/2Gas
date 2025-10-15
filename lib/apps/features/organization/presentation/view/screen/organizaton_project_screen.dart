import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/widget/card_project_widget.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/organization_controller.dart';

class OrganizatonProjectScreen extends GetView<OrganizationController> {
  const OrganizatonProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(controller.colorIcon.value),
        onPressed: () {},
        child: Icon(Iconsax.folder_add_outline, color: context.colorTextBtn),
      ),
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
                    hintText: "Search Project",
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
                controller.filtersProject.length,
                (i) => ChoiceChip(
                  label: YoText.bodyMedium(
                    controller.filtersProject[i],
                    color: controller.currentFilterProject.value == i
                        ? context.colorTextBtn
                        : context.textColor,
                  ),
                  checkmarkColor: context.colorTextBtn,
                  selected: controller.currentFilterProject.value == i,
                  onSelected: (_) => controller.changeFilterProject(i),
                ),
              ),
            ),
          ),
          CardProjectWidget(
            model: ProjectModel(
              id: "id",
              name: "Project name",
              orgId: "orgId",
              priority: Priority.low,
              status: ProjectStatus.completed,
              deadline: DateTime.now().add(Duration(days: 4, minutes: 40)),
              createdAt: DateTime.now(),
              assign: [],
              createdBy: "createdBy",
            ),
          ),
        ],
      ),
    );
  }
}
