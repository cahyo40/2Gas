import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/core/constants/database.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/data/model/member_model.dart';
import 'package:twogass/apps/data/model/project_category_model.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/project_create/domain/usecase/member_category_project_usecase.dart';
import 'package:twogass/apps/features/project_create/domain/usecase/project_create_usecase.dart';
import 'package:yo_ui/yo_ui_base.dart';

class ProjectCreateController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();
  AuthController get user => Get.find<AuthController>();
  final id = YoIdGenerator.alphanumericId();
  final formKey = GlobalKey<FormState>();
  final RxString orgId = "".obs;

  final name = TextEditingController();
  // final catCtrl = "".obs;
  final catCtrl = TextEditingController();
  final category = <ProjectCategoryModel>[].obs;
  final desc = TextEditingController();
  final deadlineCtrl = TextEditingController();
  final RxList<ProjectAssignModel> assigns = <ProjectAssignModel>[].obs;
  final Rx<Priority> priority = Priority.low.obs;
  final Rx<DateTime> deadline = DateTime.now().obs;
  final Rx<ProjectStatus> status = ProjectStatus.active.obs;

  final initialMember = <MemberModel>[].obs;
  final initialCategory = <ProjectCategoryModel>[].obs;

  ProjectCreateUsecase create = ProjectCreateUsecase(Get.find());

  GetMemberCategoryProjectUseCase memberCategory =
      GetMemberCategoryProjectUseCase(Get.find());

  initialData() async {
    isLoading.value = true;
    try {
      final data = await memberCategory(orgId.value);
      initialMember.addAll(data[DatabaseConst().member]);
      initialCategory.addAll(data[DatabaseConst().category]);
      initialMember.refresh();
      initialCategory.refresh();
    } catch (_) {
    } finally {
      isLoading.value = false;
    }
  }

  onAddCategory(String value) {
    final data = ProjectCategoryModel(
      id: YoIdGenerator.alphanumericId(),
      orgId: orgId.value,
      name: value.trim(),
    );
    initialCategory.add(data);
    initialCategory.refresh();
    category.add(data);
    category.refresh();
  }

  onSelectCategory(ProjectCategoryModel model) {
    if (category.any((e) => e.id == model.id)) {
      YoSnackBar.show(
        context: Get.context!,
        message: L10n.t.category_has_been_added,
        type: YoSnackBarType.error,
      );
    } else {
      category.add(model);
      category.refresh();
    }

    Get.back();
  }

  bool isExistCategory(ProjectCategoryModel model) {
    return category.any((e) => e.id == model.id);
  }

  onAssignMember(MemberModel member) {
    if (assigns.any((f) => f.uid.contains(member.uid))) {
      assigns.removeWhere((e) => e.uid.contains(member.uid));
    } else {
      final data = ProjectAssignModel(
        id: YoIdGenerator.alphanumericId(),
        projectId: id,
        uid: member.uid,
        imageUrl: member.imageUrl,
        orgId: orgId.value,
        playerId: member.playerId,
      );
      assigns.add(data);
    }
    assigns.refresh();
  }

  bool isAssignMember(MemberModel member) {
    return assigns.any((f) => f.uid.contains(member.uid));
  }

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

  onSumbit() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        final creatorAssign = [
          ProjectAssignModel(
            id: YoIdGenerator.alphanumericId(),
            projectId: id,
            orgId: orgId.value,
            playerId: user.playerId,
            uid: user.uid,
            imageUrl: user.photoUrl,
          ),
        ];

        final now = DateTime.now();
        final project = ProjectModel(
          id: id,
          name: name.text.trim(), // field
          orgId: orgId.value,
          priority: priority.value, // field
          status: status.value, // default active
          deadline: deadline.value, // field
          createdAt: now, //default
          createdBy: user.uid, //default
          assign: assigns.isEmpty ? creatorAssign : assigns, // field
          description: desc.text.trim(), // field
          categories: category,
        );
        await create(project);

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
  void onInit() {
    final args = Get.arguments;
    if (args is Map<String, dynamic> && args['orgId'] != null) {
      orgId.value = args['orgId'] as String;
      initialData();
    } else {
      // opsional: kembali atau tampilkan error
    }
    super.onInit();
  }
}
