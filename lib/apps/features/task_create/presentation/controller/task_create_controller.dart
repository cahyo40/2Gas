import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/core/helpers/assigners_helpers.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/project/presentation/controller/project_controller.dart';
import 'package:twogass/apps/features/task_create/domain/usecase/task_create_usecase.dart';
import 'package:yo_ui/yo_ui_base.dart';

class TaskCreateController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();

  final projectId = "".obs;
  final orgId = "".obs;
  final taskId = YoIdGenerator.alphanumericId();

  final form = GlobalKey<FormState>();
  final title = TextEditingController();
  final desc = TextEditingController();
  final deadlineCtrl = TextEditingController();
  final Rx<Priority> priority = Priority.low.obs;
  final Rx<TaskStatus> status = TaskStatus.todo.obs;
  final Rx<DateTime> deadline = DateTime.now().obs;
  final RxList<ProjectAssignModel> projectAssign = <ProjectAssignModel>[].obs;

  final RxList<TaskAssignModel> assigns = <TaskAssignModel>[].obs;

  TaskCreateUsecase createTask = TaskCreateUsecase(Get.find());

  Priority onSelectPriority(String value) {
    switch (value) {
      case "low":
        return Priority.low;
      case "medium":
        return Priority.medium;
      default:
        return Priority.high;
    }
  }

  onAssignMember(ProjectAssignModel user) {
    if (assigns.any((element) => element.uid == user.uid)) {
      assigns.removeWhere((element) => element.uid == user.uid);
      assigns.refresh();
    } else {
      final data = TaskAssignModel(
        id: YoIdGenerator.alphanumericId(),
        uid: user.uid,
        imageUrl: user.imageUrl,
        name: "",
        orgId: user.orgId,
        projectId: user.projectId,
        taskId: taskId,
      );

      assigns.add(data);
    }
    assigns.refresh();
  }

  bool isAssignMember(ProjectAssignModel user) {
    return assigns.any((f) => f.uid.contains(user.uid));
  }

  onSubmit() {
    if (form.currentState!.validate()) {
      isLoading.value = true;
      try {
        final initAssign = TaskAssignModel(
          id: YoIdGenerator.alphanumericId(),
          uid: user.uid,
          imageUrl: user.photoUrl,
          name: user.name,
          taskId: taskId,
          projectId: projectId.value,
          orgId: orgId.value,
        );
        final now = DateTime.now();
        final data = TaskModel(
          id: taskId,
          projectId: projectId.value,
          orgId: orgId.value,
          name: title.text,
          priority: priority.value,
          status: status.value,
          deadline: deadline.value,
          createdAt: now,
          description: desc.text,
          createdBy: Get.find<AuthController>().uid,
          assigns: assigns.isNotEmpty ? assigns : [initAssign],
        );
        createTask(data);
        Get.back(result: true);
      } catch (e, s) {
        YoSnackBar.show(
          context: Get.context!,
          message: "Error : $e -> $s",
          type: YoSnackBarType.error,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onInit() async {
    projectId.value = Get.arguments['projectId'];
    orgId.value = Get.arguments['orgId'];
    projectAssign.value = await AssignersHelpers.project(
      projectId: Get.arguments['projectId'],
    );
    super.onInit();
  }

  @override
  void onClose() {
    Get.find<ProjectController>().initData();
    super.onClose();
  }
}
