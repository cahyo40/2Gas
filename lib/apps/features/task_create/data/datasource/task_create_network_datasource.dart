import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/core/helpers/notification_message.dart';
import 'package:twogass/apps/core/services/firebase.dart';
import 'package:twogass/apps/core/services/notification.dart';
import 'package:twogass/apps/data/model/activity_model.dart';
import 'package:twogass/apps/data/model/notifications_model.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/schedule_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/task_create/domain/repositories/task_create_repository.dart';
import 'package:yo_ui/yo_ui.dart';

class TaskCreateNetworkDatasource implements TaskCreateRepository {
  AuthController get user => Get.find<AuthController>();
  @override
  Future<bool> createTask(TaskModel task) async {
    try {
      final idActivity = YoIdGenerator.alphanumericId();
      final scheduleId = YoIdGenerator.alphanumericId();
      List<String> uidAccess = task.assigns.map((e) => e.uid).toList();
      List<String> playerAccess = task.assigns.map((e) => e.playerId).toList();
      final notifId = YoIdGenerator.alphanumericId();

      final projectSnap = await FirebaseServices.project
          .doc(task.projectId)
          .get();
      final project = ProjectModel.fromFirestore(projectSnap);
      final activity = ActivityModel(
        createdAt: task.createdAt,
        orgId: task.orgId,
        projectId: task.projectId,
        id: idActivity,
        type: ActivityType.taskCreated,
        meta: ActivityMeta(
          taskName: task.name,
          projectName: project.name,
          user: user.name,
        ),
      );

      final schedule = ScheduleModel(
        id: scheduleId,
        uid: user.uid,
        type: ScheduleType.deadline,
        date: task.deadline,
        createdAt: task.createdAt,
        title: "Deadline Task",
        orgId: task.orgId,
        projectId: task.projectId,
        taskId: task.id,
        access: ScheduleAccess.org,
        uidAccess: task.assigns.map((e) => e.uid).toList(),
        description:
            "${task.name.capitalize!} at ${project.name.capitalize!} Project -> priority ${task.priority.name.capitalize}",
      );

      final notif = NotificationsModel(
        id: notifId,
        taskId: task.id,
        projectId: project.id,
        orgId: project.orgId,
        uidShows: uidAccess,
        createdAt: task.createdAt,
        type: NotificationType.taskAssigned,
        data: NotificationData(taskName: task.name, projectName: project.name),
      );

      await FirebaseServices.task.doc(task.id).set(task.toFirebase());
      await FirebaseServices.activity.doc(idActivity).set(activity.toJson());
      await Future.wait(
        task.assigns.map(
          (a) => FirebaseServices.taskAssign.doc(a.id).set(a.toJson()),
        ),
      );
      final title = NotificationMessage.title(
        type: NotificationType.taskAssigned,
      );
      final message = NotificationMessage.description(
        type: NotificationType.taskAssigned,
        data: NotificationData(taskName: task.name, projectName: project.name),
      );

      await NotificationService().sendNotification(
        playerIds: playerAccess,
        title: title,
        message: message,
      );
      await FirebaseServices.schedule.doc(scheduleId).set(schedule.toJson());
      await FirebaseServices.notif.doc(notifId).set(notif.toJson());

      return true;
    } on FirebaseException catch (e, s) {
      YoLogger.error('Firestore error $e -> $s');
      return false;
    } catch (e, s) {
      YoLogger.error('Unexpected error  $e-> $s');
      return false;
    }
  }
}
