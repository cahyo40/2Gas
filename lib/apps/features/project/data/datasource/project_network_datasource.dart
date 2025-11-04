import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/core/constants/database.dart';
import 'package:twogass/apps/core/services/firebase.dart';
import 'package:twogass/apps/data/model/activity_model.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/data/model/user_model.dart';
import 'package:twogass/apps/features/organization/presentation/controller/organization_controller.dart';
import 'package:twogass/apps/features/project/domain/repositories/project_repository.dart';
import 'package:yo_ui/yo_ui.dart';

class ProjectNetworkDatasource implements ProjectRepository {
  final key = DatabaseConst();
  AuthController get user => Get.find<AuthController>();
  @override
  Future<Map<String, dynamic>> projectResponse({
    required String id,
    String? orgId,
  }) async {
    try {
      /* 1. semua future diparalelkan */
      final projectFuture = FirebaseServices.project.doc(id).get();
      final projectAssignFuture = FirebaseServices.projectAssign
          .where('projectId', isEqualTo: id)
          .get();
      final createdByFuture = projectFuture.then(
        (snap) => FirebaseServices.users
            .doc(ProjectModel.fromFirestore(snap).createdBy)
            .get(),
      );
      final taskFuture = (orgId?.isNotEmpty ?? false)
          ? FirebaseServices.task
                .where('orgId', isEqualTo: orgId)
                .where('projectId', isEqualTo: id)
                .get()
          : Future.value(null); // skip kalau orgId kosong

      /* 2. tunggu sekaligus */
      final snaps = await Future.wait([
        projectFuture,
        projectAssignFuture,
        createdByFuture,
        taskFuture,
      ]);

      /* 3. mapping hasil */
      final projectSnap = snaps[0] as DocumentSnapshot<Map<String, dynamic>>;
      final project = ProjectModel.fromFirestore(projectSnap);

      final paSnap = snaps[1] as QuerySnapshot<Map<String, dynamic>>;
      final projectAssign = paSnap.docs
          .map((d) => ProjectAssignModel.fromJson(d.data()))
          .toList();

      final createdBySnap = snaps[2] as DocumentSnapshot<Map<String, dynamic>>;
      final createdBy = UserModel.fromFirestore(createdBySnap);

      final taskSnap = snaps[3] as QuerySnapshot<Map<String, dynamic>>?;
      final task =
          taskSnap?.docs.map((d) => TaskModel.fromFirestore(d)).toList() ??
          <TaskModel>[];

      return {
        key.project: project,
        key.task: task,
        key.projectAssign: projectAssign,
        'createdBy': createdBy,
      };
    } on FirebaseException catch (e, s) {
      YoLogger.error('Firestore error $e -> $s');
      rethrow;
    } catch (e, s) {
      YoLogger.error('Unexpected error  $e-> $s');
      rethrow;
    }
  }

  @override
  Future<void> updateTaskStatus({
    required taskId,
    required String projectId,
    required TaskStatus status,
  }) async {
    try {
      final activityId = YoIdGenerator.alphanumericId();
      final taskSnap = await FirebaseServices.task.doc(taskId).get();
      final taskData = TaskModel.fromFirestore(taskSnap);

      await FirebaseServices.task.doc(taskId).update({'status': status.name});

      final task = await FirebaseServices.task
          .where("projectId", isEqualTo: projectId)
          .get();

      final totalTask = task.docs.length;
      final doneTask = task.docs
          .where((d) => TaskModel.fromFirestore(d).status == TaskStatus.done)
          .length;

      final progress = totalTask == 0 ? 0 : (doneTask / totalTask) * 100;
      final projectSnap = await FirebaseServices.project.doc(projectId).get();
      final project = ProjectModel.fromFirestore(projectSnap);

      final deadline = project.deadline;
      final now = DateTime.now();

      ProjectStatus projectStatus;
      if (progress == 100) {
        projectStatus = ProjectStatus.completed;
      } else if (now.isAfter(deadline)) {
        projectStatus = ProjectStatus.overdue;
      } else {
        projectStatus = ProjectStatus.active;
      }

      final activity = ActivityModel(
        createdAt: DateTime.now(),
        orgId: Get.find<OrganizationController>().orgId.value,
        projectId: projectId,
        id: activityId,
        title: 'Task Change Status',
        type: ActivityType.taskMoved,
        description: "",
        meta: ActivityMeta(
          taskName: status.name,
          memberName: user.name,
          projectName: taskData.name,
        ),
      );

      await FirebaseServices.project.doc(projectId).update({
        'status': projectStatus.name,
      });
      await FirebaseServices.activity.doc(activityId).set(activity.toJson());
    } on FirebaseException catch (e, s) {
      YoLogger.error('Firestore error $e -> $s');
      rethrow;
    } catch (e, s) {
      YoLogger.error('Unexpected error  $e-> $s');
      rethrow;
    }
  }

  @override
  Future<void> addAssigner({required ProjectAssignModel model}) async {
    try {
      await FirebaseServices.projectAssign.doc(model.id).set(model.toJson());
      await FirebaseServices.project.doc(model.projectId).update({
        "assign": FieldValue.arrayUnion([model.toJson()]),
      });
    } on FirebaseException catch (e, s) {
      YoLogger.error('Firestore error $e -> $s');
      rethrow;
    } catch (e, s) {
      YoLogger.error('Unexpected error  $e-> $s');
      rethrow;
    }
  }
}
