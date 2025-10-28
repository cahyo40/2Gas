import 'package:get/get.dart';
import 'package:twogass/apps/core/constants/database.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/data/model/user_model.dart';
import 'package:twogass/apps/features/organization/presentation/controller/organization_controller.dart';
import 'package:twogass/apps/features/project/domain/repositories/project_repository.dart';
import 'package:twogass/apps/features/project/domain/usecase/project_usecase.dart';
import 'package:twogass/apps/features/project/domain/usecase/update_task_status_usecase.dart';
import 'package:yo_ui/yo_ui_base.dart';

final key = DatabaseConst();

class ProjectController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();

  final id = "".obs;
  final orgId = "".obs;
  final project = ProjectModel.initial().obs;
  final task = <TaskModel>[].obs;
  final taskNew = <TaskModel>[].obs;
  final createdBy = UserModel.initial().obs;
  final assignProject = <ProjectAssignModel>[].obs;

  ProjectUsecase projectUsecase = ProjectUsecase(Get.find<ProjectRepository>());
  UpdateTaskStatusUsecase updateTaskStatus = UpdateTaskStatusUsecase(
    Get.find(),
  );

  final filtersTask = ["all", "todo", "progress", 'done'];
  final currentFilterTask = 0.obs;
  changeFilterTask(int index) {
    currentFilterTask.value = index;
    if (index == 0) {
      taskNew.value = task;
    } else {
      taskNew.value = task
          .where((d) => d.status.name == filtersTask[index])
          .toList();
    }
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
      project.value = data[key.project];
      task.value = data[key.task];
      taskNew.value = task;
      assignProject.value = data[key.projectAssign];
      createdBy.value = data["createdBy"];
    } catch (_) {
    } finally {
      isLoading.value = false;
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
