import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/routes/route_names.dart';
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
        onPressed: () async {
          final result = await Get.toNamed(
            RouteNames.PROJECT_CREATE,
            arguments: {"orgId": controller.org.value.id},
          );
          if (result == true && context.mounted) {
            controller.initOrg(controller.orgId.value);
            YoSnackBar.show(
              context: context,
              message: "Sukses menambah Project",
            );
          }
        },
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
              spacing: 6,
              runSpacing: 6,
              children: List.generate(
                controller.filtersProject.length,
                (i) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: controller.currentFilterProject.value == i
                        ? Color(
                            controller.org.value.color ??
                                context.primaryColor.toARGB32(),
                          )
                        : Colors.transparent,
                    border: Border.all(
                      color: controller.currentFilterProject.value == i
                          ? Colors.transparent
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => controller.changeFilterProject(i),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: YoText.bodyMedium(
                          controller.filtersProject[i].capitalize!,
                          color: controller.currentFilterProject.value == i
                              ? context.onPrimaryBW
                              : Colors.grey.shade700,
                          fontWeight: controller.currentFilterProject.value == i
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
          SizedBox(height: YoSpacing.md),
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: controller.projectShow.length,
              itemBuilder: (_, i) {
                final model = controller.projectShow[i];
                return CardProjectWidget(
                  onTap: () {
                    Get.toNamed(
                      RouteNames.PROJECT,
                      arguments: {"orgId": model.orgId, "id": model.id},
                    );
                  },
                  model: model,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
