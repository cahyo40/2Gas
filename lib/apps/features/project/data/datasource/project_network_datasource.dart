import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/core/constants/database.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/core/services/firebase.dart';
import 'package:twogass/apps/data/model/activity_model.dart';
import 'package:twogass/apps/data/model/notifications_model.dart';
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
      final notifId = YoIdGenerator.alphanumericId();
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
        final activityIdCompleted = YoIdGenerator.alphanumericId();
        final activityCompleted = ActivityModel(
          id: activityIdCompleted,
          orgId: Get.find<OrganizationController>().orgId.value,
          type: ActivityType.projectCompleted,
          createdAt: now,
          meta: ActivityMeta(info: YoDateFormatter.formatDateTime(now)),
        );
        await FirebaseServices.activity
            .doc(activityIdCompleted)
            .set(activityCompleted.toJson());
      } else if (now.isAfter(deadline)) {
        projectStatus = ProjectStatus.overdue;
      } else {
        projectStatus = ProjectStatus.active;
      }

      final activity = ActivityModel(
        createdAt: DateTime.now(),
        orgId: Get.find<OrganizationController>().orgId.value,
        projectId: projectId,
        taskId: taskData.id,
        id: activityId,

        type: ActivityType.taskMoved,

        meta: ActivityMeta(
          taskName: status.name,
          user: user.name,
          info: "${taskData.status.name} -> ${status.name}",
        ),
      );

      List<String> uidAccess = taskData.assigns.map((e) => e.uid).toList();
      List<String> uidShow() {
        if (uidAccess.contains(project.createdBy)) {
          return uidAccess;
        } else {
          uidAccess.add(project.createdBy);
          return uidAccess;
        }
      }

      final notif = NotificationsModel(
        id: notifId,
        projectId: project.id,
        taskId: taskData.id,
        orgId: project.orgId,
        uidShows: uidShow(),
        type: NotificationType.taskUpdated,
        createdAt: now,
        data: NotificationData(
          projectName: project.name,
          taskName: taskData.name,
        ),
      );

      await FirebaseServices.project.doc(projectId).update({
        'status': projectStatus.name,
      });
      await FirebaseServices.notif.doc(notifId).set(notif.toJson());
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
      /* ---------- 1. cek project ---------- */
      final pRef = FirebaseServices.project.doc(model.projectId);
      final pSnap = await pRef.get();
      if (!pSnap.exists) throw Exception('Project not found');
      final project = ProjectModel.fromFirestore(pSnap);

      /* ---------- 2. cek duplikat ---------- */
      final exist = await FirebaseServices.projectAssign
          .where('projectId', isEqualTo: model.projectId)
          .where('uid', isEqualTo: model.uid)
          .limit(1)
          .get();
      if (exist.docs.isNotEmpty) return; // sudah ada, skip saja

      /* ---------- 3. tulis data ---------- */
      await FirebaseServices.projectAssign.doc(model.id).set(model.toJson());

      // cukup simpan uid di array (bukan seluruh objek)
      await pRef.update({
        'assign': FieldValue.arrayUnion([model.toJson()]),
      });

      /* ---------- 4. kirim notif ---------- */
      final notif = NotificationsModel(
        id: YoIdGenerator.alphanumericId(),
        orgId: project.orgId,
        projectId: project.id,
        uidShows: [model.uid],
        type: NotificationType.projectUserAdded,
        createdAt: DateTime.now(),
        data: NotificationData(projectName: project.name),
      );
      await FirebaseServices.notif.doc(notif.id).set(notif.toJson());
    } on FirebaseException catch (e, s) {
      YoLogger.error('Firestore error $e -> $s');
      rethrow;
    } catch (e, s) {
      YoLogger.error('Unexpected error  $e -> $s');
      rethrow;
    }
  }

  @override
  Future<void> updateProject(ProjectModel model) async {
    try {
      final idActivity = YoIdGenerator.alphanumericId();
      final notifId = YoIdGenerator.alphanumericId();
      List<String> uidAccess = model.assign.map((e) => e.uid).toList();
      final now = DateTime.now();
      final projectSnap = await FirebaseServices.project.doc(model.id).get();
      final project = ProjectModel.fromFirestore(projectSnap);

      final activity = ActivityModel(
        id: idActivity,
        orgId: model.orgId,
        type: ActivityType.projectUpdated,
        createdAt: now,
        meta: ActivityMeta(user: user.name, info: diffProject(project, model)),
      );
      final notif = NotificationsModel(
        id: notifId,
        orgId: model.orgId,
        projectId: model.id,
        uidShows: uidAccess,
        type: NotificationType.projectDataUpdated,
        createdAt: now,
        data: NotificationData(projectName: model.name),
      );

      await FirebaseServices.notif.doc(notifId).set(notif.toJson());
      await FirebaseServices.project.doc(model.id).update(model.toJson());
      await FirebaseServices.activity.doc(idActivity).set(activity.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTask(TaskModel task) async {
    try {
      final idActivity = YoIdGenerator.alphanumericId();
      final notifId = YoIdGenerator.alphanumericId();
      final uidAccess = task.assigns.map((e) => e.uid).toList();
      final projectSnap = await FirebaseServices.project
          .doc(task.projectId)
          .get();
      final project = ProjectModel.fromFirestore(projectSnap);
      final now = DateTime.now();

      final activity = ActivityModel(
        id: idActivity,
        orgId: task.orgId,
        projectId: task.projectId,
        type: ActivityType.taskDeleted,
        createdAt: now,
        meta: ActivityMeta(
          taskName: task.name,
          user: user.name,
          projectName: project.name,
        ),
      );

      final notif = NotificationsModel(
        id: notifId,
        orgId: task.orgId,
        projectId: task.id,
        uidShows: uidAccess,
        type: NotificationType.taskUpdated,
        createdAt: now,
        data: NotificationData(taskName: task.name),
      );

      await FirebaseServices.task.doc(task.id).delete();

      final assignSnap = await FirebaseServices.taskAssign
          .where('taskId', isEqualTo: task.id)
          .get();

      await Future.wait([
        FirebaseServices.activity.doc(idActivity).set(activity.toJson()),
        FirebaseServices.notif.doc(notifId).set(notif.toJson()),
        ...assignSnap.docs.map((doc) => doc.reference.delete()),
      ]);
    } catch (e, s) {
      YoLogger.error('deleteTask error: $e\n$s');
      rethrow;
    }
  }

  // Fungsi untuk mengetahui perbedaan yang ada pada 2 buah class Model Project

  String diffProject(ProjectModel a, ProjectModel b) {
    final buf = StringBuffer();

    void addIfDiff(String label, dynamic oldVal, dynamic newVal) {
      if (oldVal != newVal) {
        buf.write('• $label:');
        buf.write('  $oldVal');
        buf.write('  -> $newVal');
      }
    }

    addIfDiff(
      L10n.t.priority,
      a.priority.name.capitalize,
      b.priority.name.capitalize,
    );
    addIfDiff('Status', a.status.name, b.status.name);
    addIfDiff(L10n.t.description, a.description, b.description);
    addIfDiff(
      L10n.t.deadline,
      YoDateFormatter.formatDate(a.deadline),
      YoDateFormatter.formatDate(b.deadline),
    );

    return buf.isEmpty ? 'Tidak ada perbedaan.' : buf.toString();
  }

  @override
  Future<void> deleteProject(ProjectModel model) async {
    try {
      final activityId = YoIdGenerator.alphanumericId();

      final now = DateTime.now();

      final activity = ActivityModel(
        id: activityId,
        orgId: model.orgId,
        type: ActivityType.projectDeleted,
        createdAt: now,
        meta: ActivityMeta(
          user: user.name,
          info: YoDateFormatter.formatDate(now),
        ),
      );

      final taskSnap = await FirebaseServices.task
          .where("projectId", isEqualTo: model.id)
          .get();
      final taskAssignSnap = await FirebaseServices.taskAssign
          .where("projectId", isEqualTo: model.id)
          .get();
      final projectAssignSnap = await FirebaseServices.projectAssign
          .where("projectId", isEqualTo: model.id)
          .get();
      final scheduleSnap = await FirebaseServices.schedule
          .where("projectId", isEqualTo: model.id)
          .get();

      Future.wait([
        FirebaseServices.project.doc(model.id).delete(),
        FirebaseServices.activity.doc(activityId).set(activity.toJson()),
        ...taskSnap.docs.map((doc) => doc.reference.delete()),
        ...taskAssignSnap.docs.map((doc) => doc.reference.delete()),
        ...projectAssignSnap.docs.map((doc) => doc.reference.delete()),
        ...scheduleSnap.docs.map((doc) => doc.reference.delete()),
      ]);
    } catch (e, s) {
      YoLogger.error('deleteTask error: $e\n$s');
      rethrow;
    }
  }
}
