import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/core/services/firebase.dart';
import 'package:twogass/apps/data/model/activity_model.dart';
import 'package:twogass/apps/data/model/member_model.dart';
import 'package:twogass/apps/data/model/notifications_model.dart';
import 'package:twogass/apps/data/model/organitation_model.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/schedule_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/organization/domain/repositories/organization_repository.dart';
import 'package:twogass/apps/features/organization/presentation/controller/organization_controller.dart';
import 'package:yo_ui/yo_ui_base.dart';

class OrganizationNetworkDatasource implements OrganizationRepository {
  AuthController get user => Get.find<AuthController>();

  @override
  Future<OrganizationModel> getOrganization(String orgId) async {
    try {
      final data = await FirebaseServices.org.doc(orgId).get();
      return OrganizationModel.fromFirestore(data);
    } catch (_) {
      return OrganizationModel.initial();
    }
  }

  @override
  Future<List<ActivityModel>> getActivity(String orgId) async {
    try {
      final data = await FirebaseServices.activity
          .where("orgId", isEqualTo: orgId)
          .orderBy("createdAt", descending: true)
          .get();
      return data.docs
          .map((docs) => ActivityModel.fromFirestore(docs))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<ProjectModel>> getProject(String orgId) async {
    try {
      final data = await FirebaseServices.project
          .where("orgId", isEqualTo: orgId)
          .orderBy("deadline", descending: false)
          .get();
      return data.docs.map((docs) => ProjectModel.fromFirestore(docs)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<TaskModel>> getTask(String orgId, String? projectId) async {
    try {
      Query<Map<String, dynamic>> query = FirebaseServices.task.where(
        'orgId',
        isEqualTo: orgId,
      );
      if (projectId != null && projectId.trim().isNotEmpty) {
        query = query.where('projectId', isEqualTo: projectId);
      }
      final data = await query.orderBy('deadline', descending: true).get();
      return data.docs.map((doc) => TaskModel.fromFirestore(doc)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<MemberModel>> getMember(String orgId) async {
    try {
      final res = await FirebaseServices.member
          .where("orgId", isEqualTo: orgId)
          .get();
      return res.docs.map((doc) => MemberModel.fromFirestore(doc)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> acceptMember(MemberModel member) async {
    try {
      final activityId = YoIdGenerator.alphanumericId();
      final notifId = YoIdGenerator.alphanumericId();
      final now = DateTime.now();
      final updateData = {"isPending": false, "joinedAt": DateTime.now()};

      final notif = NotificationsModel(
        id: notifId,

        uidShows: [member.uid],
        type: NotificationType.orgAccessRequestApproved,
        createdAt: now,
        orgId: Get.find<OrganizationController>().org.value.id,
        data: NotificationData(
          orgName: Get.find<OrganizationController>().org.value.name,
        ),
      );

      final activity = ActivityModel(
        createdAt: now,
        orgId: Get.find<OrganizationController>().orgId.value,
        id: activityId,
        type: ActivityType.memberJoin,
        meta: ActivityMeta(
          user: member.name,
          orgName: Get.find<OrganizationController>().org.value.name,
        ),
      );
      await FirebaseServices.notif.doc(notifId).set(notif.toJson());
      await FirebaseServices.activity.doc(activityId).set(activity.toJson());
      await FirebaseServices.member.doc(member.id).update(updateData);
    } catch (e, s) {
      YoLogger.error("$e -> $s");
      rethrow;
    }
  }

  @override
  Future<List<ScheduleModel>> getSchedule(String orgId) async {
    try {
      final res = await FirebaseServices.schedule
          .where("orgId", isEqualTo: orgId)
          .orderBy("date", descending: false)
          .get();
      final data = res.docs
          .map((doc) => ScheduleModel.fromFirestore(doc))
          .toList();
      YoLogger.debug("Data => ${data.first.toJson()}");
      return data;
    } catch (e) {
      YoLogger.error(e.toString());
      return [];
    }
  }

  @override
  Future<void> changeRoleMember(MemberModel member, MemberRole role) async {
    try {
      final notifId = YoIdGenerator.alphanumericId();
      final activityId = YoIdGenerator.alphanumericId();

      final now = DateTime.now();
      final updateData = {"role": role.name};

      final activity = ActivityModel(
        id: activityId,
        orgId: Get.find<OrganizationController>().org.value.id,
        type: ActivityType.memberChangeRole,
        createdAt: now,
        meta: ActivityMeta(user: member.name, info: role.name.capitalize!),
      );

      final notif = NotificationsModel(
        id: notifId,
        uidShows: [member.uid],
        type: NotificationType.orgRoleChangedToAdmin,
        createdAt: now,
        orgId: Get.find<OrganizationController>().org.value.id,
        data: NotificationData(
          orgName: Get.find<OrganizationController>().org.value.name,
        ),
      );

      Future.wait([
        FirebaseServices.member.doc(member.id).update(updateData),
        FirebaseServices.notif.doc(notifId).set(notif.toJson()),
        FirebaseServices.activity.doc(activityId).set(activity.toJson()),
      ]);
    } catch (e) {
      YoLogger.error("Change Role Member Error $e");
      rethrow;
    }
  }

  @override
  Future<void> memberOut(MemberModel member, {bool isKick = false}) async {
    try {
      // Notification
      final notifId = YoIdGenerator.alphanumericId();
      final activityId = YoIdGenerator.alphanumericId();
      final now = DateTime.now();
      var uidShow = <String>[];

      final memberSnap = await FirebaseServices.member
          .where("orgId", isEqualTo: member.orgId)
          .where("role", isNotEqualTo: MemberRole.member.name)
          .get();

      if (isKick == true) {
        uidShow = [member.uid];
      } else {
        uidShow = memberSnap.docs
            .map((data) => data['uid'] as String)
            .toSet()
            .toList();
      }

      final activity = ActivityModel(
        id: activityId,
        orgId: Get.find<OrganizationController>().org.value.id,
        type: isKick ? ActivityType.memberRemoved : ActivityType.memberLeft,
        createdAt: now,
        meta: ActivityMeta(
          user: isKick ? user.name : member.name,
          info: member.name,
        ),
      );

      final notif = NotificationsModel(
        id: notifId,
        uidShows: uidShow,
        type: NotificationType.orgUserRemoved,
        createdAt: now,
        orgId: Get.find<OrganizationController>().org.value.id,
        data: NotificationData(
          orgName: Get.find<OrganizationController>().org.value.name,
        ),
      );
      //Project
      final project = await FirebaseServices.projectAssign
          .where("uid", isEqualTo: member.uid)
          .get();
      final projectId = project.docs.map((d) => d.id).toSet().toList();
      // Task
      final task = await FirebaseServices.taskAssign
          .where("uid", isEqualTo: member.uid)
          .get();
      final taskId = task.docs.map((id) => id.id).toSet().toList();

      if (projectId.isNotEmpty) {
        await Future.wait(
          projectId.map(
            (id) => FirebaseServices.projectAssign.doc(id).delete(),
          ),
        );
      }
      if (taskId.isNotEmpty) {
        await Future.wait(
          taskId.map((id) => FirebaseServices.taskAssign.doc(id).delete()),
        );
      }
      Future.wait([
        FirebaseServices.member.doc(member.id).delete(),
        FirebaseServices.notif.doc(notifId).set(notif.toJson()),
        FirebaseServices.activity.doc(activityId).set(activity.toJson()),
      ]);
    } catch (e) {
      YoLogger.error("Kick Member Error $e");
      rethrow;
    }
  }
}
