import 'package:get/get.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/task/domain/usecase/fetch_project_user_usecase.dart';
import 'package:twogass/apps/features/task/domain/usecase/fetch_task_user_usecase.dart';
import 'package:yo_ui/yo_ui.dart';

class TaskController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();

  FetchTaskUserUsecase fetchTask = FetchTaskUserUsecase(Get.find());
  FetchProjectUserUsecase fetchProject = FetchProjectUserUsecase(Get.find());

  RxList<TaskModel> tasks = <TaskModel>[].obs;
  RxList<TaskModel> taskShow = <TaskModel>[].obs;
  RxList<ProjectModel> projects = <ProjectModel>[].obs;

  Rx<TaskStatus> taskFilter = TaskStatus.all.obs;
  Rx<int> projectFilter = 0.obs;

  iniData({bool useLoading = true}) async {
    isLoading.value = useLoading;
    try {
      final res = await Future.wait([fetchTask(), fetchProject()]);
      tasks.value = res[0] as List<TaskModel>;
      projects.value = res[1] as List<ProjectModel>;
      taskShow.value = tasks;
    } catch (e, s) {
      YoLogger.error("$e -> $s");
    } finally {
      isLoading.value = false;
    }
  }

  onFilterTask(TaskStatus status) {
    taskFilter.value = status;

    // Filter berdasarkan project dulu
    List<TaskModel> filteredList;
    if (projectFilter.value == 0) {
      filteredList = tasks;
    } else {
      final projectId = projects[projectFilter.value - 1].id;
      filteredList = tasks.where((e) => e.projectId == projectId).toList();
    }

    // Kemudian filter berdasarkan status
    if (status != TaskStatus.all) {
      filteredList = filteredList.where((e) => e.status == status).toList();
    }

    taskShow.value = filteredList;
    taskShow.refresh();
  }

  resetFilter() {
    taskFilter.value = TaskStatus.all;
    projectFilter.value = 0;
    taskShow.value = tasks;
    taskShow.refresh();
  }

  onProjectFilter(int index) {
    projectFilter.value = index;

    // Filter berdasarkan status dulu
    List<TaskModel> filteredList;
    if (taskFilter.value == TaskStatus.all) {
      filteredList = tasks;
    } else {
      filteredList = tasks.where((e) => e.status == taskFilter.value).toList();
    }

    // Kemudian filter berdasarkan project
    if (index != 0) {
      final projectId = projects[index - 1].id;
      filteredList = filteredList
          .where((e) => e.projectId == projectId)
          .toList();
    }

    taskShow.value = filteredList;
    taskShow.refresh();
  }
}
