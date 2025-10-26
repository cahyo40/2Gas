import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/core/services/firebase.dart';
import 'package:twogass/apps/data/model/activity_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/task_create/domain/repositories/task_create_repository.dart';
import 'package:yo_ui/yo_ui.dart';

class TaskCreateNetworkDatasource implements TaskCreateRepository {
  final user = Get.find<AuthController>();
  @override
  Future<bool> createTask(TaskModel task) async {
    try {
      final idActivity = YoIdGenerator.alphanumericId();
      final activity = ActivityModel(
        createdAt: task.createdAt,
        orgId: task.orgId,
        projectId: task.projectId,
        id: idActivity,
        title: 'Task Created',
        type: ActivityType.taskCreated,
        description: "",
        meta: ActivityMeta(
          projectName: task.name,
          taskName: task.name,
          organizationName: user.name,
        ),
      );

      await FirebaseServices.task.doc(task.id).set(task.toJson());
      await FirebaseServices.activity.doc(idActivity).set(activity.toJson());
      await Future.wait(
        task.assigns.map(
          (a) => FirebaseServices.taskAssign.doc(a.id).set(a.toJson()),
        ),
      );

      return true;
    } on FirebaseException catch (e, s) {
      YoLogger.error('Firestore error $e -> $s');
      return false;
    } catch (e, s) {
      YoLogger.error('Unexpected error  $e-> $s');
      return false;
    }
  }

  // TODO: remote api calls
}
