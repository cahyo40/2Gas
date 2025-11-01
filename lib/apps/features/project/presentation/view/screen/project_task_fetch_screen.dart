import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/organization/presentation/controller/organization_controller.dart';
import 'package:twogass/apps/features/project/presentation/controller/project_controller.dart';
import 'package:twogass/apps/routes/route_names.dart';
import 'package:twogass/apps/widget/card_task_widget.dart';
import 'package:yo_ui/yo_ui.dart';

class OrganizatonTaskScreen extends GetView<ProjectController> {
  const OrganizatonTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orgColor = Get.find<OrganizationController>().org.value.color;
    return Scaffold(
      floatingActionButton: Visibility(
        visible: controller.isAssigner.value,
        child: FloatingActionButton(
          backgroundColor: Color(orgColor ?? context.primaryColor.toARGB32()),
          onPressed: () async {
            final result = await Get.toNamed(
              RouteNames.TASK_CREATE,
              arguments: {
                "projectId": controller.id.value,
                "orgId": controller.orgId.value,
              },
            );

            if (result == true && context.mounted) {
              YoSnackBar.show(
                context: context,
                message: "Task created successfully",
                type: YoSnackBarType.success,
              );
            }
          },
          child: Icon(Iconsax.note_add_outline, color: context.onPrimaryColor),
        ),
      ),
      appBar: AppBar(
        title: YoText.titleLarge("Tasks ${controller.project.value.name}"),
      ),
      body: RefreshIndicator(
        onRefresh: () async => await controller.refreshTask(),
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(), // Ubah ini
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
                IconButton(
                  onPressed: () {},
                  icon: Icon(Iconsax.filter_outline),
                ),
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
            SizedBox(height: YoSpacing.md),
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // Tambah ini
                itemCount: controller.taskNew.length,
                itemBuilder: (context, index) {
                  final model = controller.taskNew[index];
                  return CardTaskWidget(
                    model: model,
                    onLongPress: () {
                      if (controller.isAssigner.value) {
                        YoBottomSheet.show(
                          context: context,
                          title: "Change Status",
                          maxHeight: 400,
                          child: ListView(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            children: TaskStatus.values.map((status) {
                              return ListTile(
                                title: YoText.bodyMedium(
                                  status.name.capitalize!,
                                ),
                                trailing: model.status == status
                                    ? Icon(
                                        Iconsax.tick_square_outline,
                                        color: Color(
                                          orgColor ??
                                              context.primaryColor.toARGB32(),
                                        ),
                                      )
                                    : null,
                                onTap: () async {
                                  Get.back();
                                  await controller.updateStatusTask(
                                    model.id,
                                    model.projectId,
                                    status,
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        );
                      } else {
                        YoSnackBar.show(
                          context: context,
                          message: "Anda bukan anggota",
                          type: YoSnackBarType.warning,
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
