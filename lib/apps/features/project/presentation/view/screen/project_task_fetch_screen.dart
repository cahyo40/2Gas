import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/features/organization/presentation/controller/organization_controller.dart';
import 'package:twogass/apps/features/project/presentation/controller/project_controller.dart';
import 'package:yo_ui/yo_ui.dart';

class OrganizatonTaskScreen extends GetView<ProjectController> {
  const OrganizatonTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orgColor = Get.find<OrganizationController>().org.value.color;
    return Scaffold(
      appBar: AppBar(
        title: YoText.titleLarge("Tasks ${controller.project.value.name}"),
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
              spacing: 6,
              runSpacing: 6,
              children: List.generate(
                controller.filtersTask.length,
                (i) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: controller.currentFilterTask.value == i
                        ? Color(orgColor ?? context.primaryColor.toARGB32())
                        : Colors.transparent,
                    border: Border.all(
                      color: controller.currentFilterTask.value == i
                          ? Colors.transparent
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => controller.changeFilterTask(i),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: YoText.bodyMedium(
                          controller.filtersTask[i].capitalize!,
                          color: controller.currentFilterTask.value == i
                              ? context.colorTextBtn
                              : Colors.grey.shade700,
                          fontWeight: controller.currentFilterTask.value == i
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
