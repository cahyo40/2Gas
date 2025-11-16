import 'package:get/get.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/core/services/firebase.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/task/domain/repositories/task_repository.dart';
import 'package:yo_ui/yo_ui_base.dart';

class TaskNetworkDatasource implements TaskRepository {
  String get uid => Get.find<AuthController>().uid;
  @override
  Future<List<ProjectModel>> getProject() async {
    YoLogger.debug("Start GetProject");
    try {
      final assignProject = await FirebaseServices.projectAssign
          .where("uid", isEqualTo: uid)
          .get();

      final projectId = assignProject.docs
          .map((doc) => ProjectAssignModel.fromFirestore(doc).projectId)
          .toList();
      final projectFuture = projectId
          .map((e) => FirebaseServices.project.doc(e).get())
          .toList();

      final project = await Future.wait(projectFuture);

      final data = project.map((e) => ProjectModel.fromFirestore(e)).toList();
      YoLogger.info("Success data");
      return data;
    } catch (e, s) {
      YoLogger.error("GetProject $e -> $s");
      return []; // atau rethrow;
    }
  }

  @override
  Future<List<TaskModel>> getTask() async {
    try {
      // 1. task-assign milik user
      final assignSnap = await FirebaseServices.taskAssign
          .where('uid', isEqualTo: uid)
          .get();

      if (assignSnap.docs.isEmpty) return [];

      final taskIds = assignSnap.docs
          .map((d) => d['taskId'] as String)
          .toSet()
          .toList();

      if (taskIds.isEmpty) return [];

      final snaps = await Future.wait(
        taskIds.map((id) => FirebaseServices.task.doc(id).get()),
      );

      final tasks = snaps
          .where((s) => s.exists)
          .map((s) => TaskModel.fromFirestore(s))
          .toList();

      return tasks;
    } catch (_) {
      return []; // atau rethrow;
    }
  }
}
