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

      // 2. daftar task-id (pastikan field-nya benar: taskId atau id?)
      final taskIds = assignSnap.docs
          .map((d) => TaskAssignModel.fromFirestore(d).taskId) // <-- sesuaikan
          .toList();

      // 3. ambil semua dokumen task secara paralel
      final taskFutures = taskIds
          .map((id) => FirebaseServices.task.doc(id).get())
          .toList();

      final taskDocs = await Future.wait(taskFutures);

      // 4. mapping ke model
      return taskDocs.map((doc) => TaskModel.fromFirestore(doc)).toList();
    } catch (_) {
      return []; // atau rethrow;
    }
  }
}
