import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/core/constants/database.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/data/model/comment_model.dart';
import 'package:twogass/apps/data/model/member_model.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/data/model/user_model.dart';
import 'package:twogass/apps/features/organization/domain/usecase/fetch_member_org_usecase.dart';
import 'package:twogass/apps/features/organization/presentation/controller/organization_controller.dart';
import 'package:twogass/apps/features/project/domain/repositories/project_repository.dart';
import 'package:twogass/apps/features/project/domain/usecase/add_assigner_usecase.dart';
import 'package:twogass/apps/features/project/domain/usecase/add_comment_usecase.dart';
import 'package:twogass/apps/features/project/domain/usecase/delete_project_usecase.dart';
import 'package:twogass/apps/features/project/domain/usecase/delete_task_usecase.dart';
import 'package:twogass/apps/features/project/domain/usecase/fetch_comment_usecase.dart';
import 'package:twogass/apps/features/project/domain/usecase/project_usecase.dart';
import 'package:twogass/apps/features/project/domain/usecase/update_project_usecase.dart';
import 'package:twogass/apps/features/project/domain/usecase/update_task_status_usecase.dart';
import 'package:twogass/apps/features/project/presentation/view/screen/project_assign_screen.dart';
import 'package:yo_ui/yo_ui_base.dart';

final key = DatabaseConst();
AuthController get user => Get.find<AuthController>();

class ProjectController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();

  final id = "".obs;
  final orgId = "".obs;
  final project = ProjectModel.initial().obs;
  final task = <TaskModel>[].obs;
  final taskFilter = <TaskModel>[].obs;
  final taskNew = <TaskModel>[].obs;
  final members = <MemberModel>[].obs;
  final comments = <CommentModel>[].obs;
  final createdBy = UserModel.initial().obs;
  final assignProject = <ProjectAssignModel>[].obs;
  final RxBool isAssigner = false.obs;

  final commentCtrl = TextEditingController();
  final form = GlobalKey<FormState>();

  ProjectUsecase projectUsecase = ProjectUsecase(Get.find<ProjectRepository>());
  UpdateTaskStatusUsecase updateTaskStatus = UpdateTaskStatusUsecase(
    Get.find(),
  );
  FetchMemberOrgUsecase getMember = FetchMemberOrgUsecase(Get.find());
  AddAssignerUsecase addAssign = AddAssignerUsecase(Get.find());
  UpdateProjectUsecase updateProject = UpdateProjectUsecase(Get.find());
  DeleteTaskUsecase deleteTask = DeleteTaskUsecase(Get.find());
  AddCommentUsecase addComment = AddCommentUsecase(Get.find());
  FetchCommentUsecase fetchComment = FetchCommentUsecase(Get.find());
  DeleteProjectUsecase deleteProject = DeleteProjectUsecase(Get.find());

  final filtersTask = ["all", "todo", "progress", 'done'];
  final currentFilterTask = 0.obs;

  onTaskFilter(int index) {
    currentFilterTask.value = index;
    if (currentFilterTask.value == 0) {
      taskFilter.value = taskNew;
    } else {
      taskFilter.value = taskNew
          .where(
            (task) => task.status == TaskStatus.values[currentFilterTask.value],
          )
          .toList();
    }
    taskFilter.refresh();
  }

  updateStatusTask(String taskId, String projectId, TaskStatus status) async {
    await updateTaskStatus.call(
      taskId: taskId,
      status: status,
      projectId: projectId,
    );
    await initData(useLoading: false);
  }

  refreshTask() async {
    await initData(useLoading: false);
  }

  initData({bool useLoading = true}) async {
    isLoading.value = useLoading;
    try {
      final data = await projectUsecase(id.value, orgId.value);
      comments.value = await fetchComment(id.value);
      project.value = data[key.project];
      task.value = data[key.task];
      taskNew.value = task.where((e) => e.status != TaskStatus.done).toList()
        ..sort((a, b) => (a.deadline).compareTo(b.deadline));
      taskFilter.value = taskNew;
      assignProject.value = data[key.projectAssign];
      createdBy.value = data["createdBy"];
      final allMember = await getMember(orgId.value);
      members.value = allMember.where((e) => e.isPending == false).toList();
      isAssigner.value = assignProject
          .where((e) => e.uid == user.uid)
          .isNotEmpty;
    } catch (_) {
    } finally {
      isLoading.value = false;
    }
  }

  goToAssignProject() async {
    currentFilterTask.value = 0;
    taskFilter.value = taskNew;
    taskFilter.refresh();
    Get.back();
    Get.to(() => ProjectAssignScreen());
  }

  addAssigner(MemberModel model) async {
    final assignId = YoIdGenerator.alphanumericId();
    ProjectAssignModel data = ProjectAssignModel(
      playerId: model.playerId,
      id: assignId,
      projectId: id.value,
      uid: model.uid,
      orgId: orgId.value,
      imageUrl: model.imageUrl,
    );
    await addAssign(data);
    initData(useLoading: true);
  }

  bool isCreator(String uid) {
    return user.uid == uid;
  }

  updatePriority(Priority priority) async {
    if (isAssigner.isTrue) {
      final projectUpdate = project.value.copyWith(priority: priority);
      await updateProject(projectUpdate);
      initData(useLoading: true);
    } else {
      YoSnackBar.show(
        context: Get.context!,
        message: L10n.t.msg_cannot_change_data,
        type: YoSnackBarType.error,
      );
    }
  }

  updateDeadline(DateTime date) async {
    if (isAssigner.isTrue) {
      final projectUpdate = project.value.copyWith(deadline: date);
      await updateProject(projectUpdate);
      initData(useLoading: true);
    } else {
      YoSnackBar.show(
        context: Get.context!,
        message: L10n.t.msg_cannot_change_data,
        type: YoSnackBarType.error,
      );
    }
  }

  onDeleteTask(TaskModel task) async {
    await deleteTask(task);
    initData(useLoading: true);
  }

  onDeleteProject() async {
    await deleteProject(project.value);
    Get.back();
  }

  onAddComment() async {
    try {
      if (form.currentState!.validate()) {
        final commentId = YoIdGenerator.alphanumericId();
        final data = CommentModel(
          id: commentId,
          orgId: orgId.value,
          projectId: id.value,
          createdBy: user.uid,
          comment: commentCtrl.text.trim(),
          createdAt: DateTime.now(),
        );

        await addComment(data);
      }
    } catch (_) {
    } finally {
      comments.value = await fetchComment(id.value);
      commentCtrl.clear();
    }
  }

  @override
  void onInit() {
    id.value = Get.arguments['id'];
    orgId.value = Get.arguments['orgId'];
    initData();
    YoLogger.info(orgId.value);
    super.onInit();
  }

  @override
  void onClose() {
    Get.find<OrganizationController>().initOrg(
      Get.find<OrganizationController>().orgId.value,
      useLoading: false,
    );
    super.onClose();
  }
}
