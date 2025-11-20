import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/core/helpers/notification_message.dart';
import 'package:twogass/apps/core/services/firebase.dart';
import 'package:twogass/apps/core/services/notification.dart';
import 'package:twogass/apps/data/model/member_model.dart';
import 'package:twogass/apps/data/model/notifications_model.dart';
import 'package:twogass/apps/data/model/organitation_model.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/home/data/models/organization_home_response.dart';
import 'package:twogass/apps/features/home/domain/repositories/home_repository.dart';
import 'package:yo_ui/yo_ui.dart';

class HomeNetworkDatasource implements HomeRepository {
  AuthController get user => Get.find<AuthController>();
  @override
  Future<List<OrganizationHomeResponseModel>> homeOrganization() async {
    try {
      final myOrg = await FirebaseServices.member
          .where("uid", isEqualTo: user.uid)
          .where("isPending", isEqualTo: false)
          .get();
      final orgsId = myOrg.docs
          .map((d) => MemberModel.fromFirestore(d).orgId)
          .toSet()
          .toList();

      if (orgsId.isEmpty) return [];
      final data = orgsId.map((id) async {
        final org = await FirebaseServices.org.doc(id).get();
        final model = OrganizationModel.fromFirestore(org);

        final membersSnap = await FirebaseServices.member
            .where("orgId", isEqualTo: model.id)
            .get();

        final members = membersSnap.docs
            .map((m) => MemberModel.fromFirestore(m))
            .toList();

        final projectSnap = await FirebaseServices.project
            .where("orgId", isEqualTo: model.id)
            .get();

        var project = <ProjectModel>[];
        if (projectSnap.docs.isEmpty) {
          project = [];
        } else {
          project = projectSnap.docs
              .map((docs) => ProjectModel.fromFirestore(docs))
              .toList();
        }

        return OrganizationHomeResponseModel(
          org: model,
          members: members,
          projects: project,
        );
      });
      return Future.wait(data);
    } on FirebaseException catch (e, s) {
      YoLogger.error('Firestore error $e -> $s');
      rethrow;
    } catch (e, s) {
      YoLogger.error('Unexpected error  $e-> $s');
      rethrow;
    }
  }

  @override
  Future<List<TaskModel>> userTask() async {
    try {
      final myTask = await FirebaseServices.taskAssign
          .where("uid", isEqualTo: user.uid)
          .get();

      final taskIds = myTask.docs
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
    } on FirebaseException catch (e, s) {
      YoLogger.error('Firestore error $e -> $s');
      rethrow;
    } catch (e, s) {
      YoLogger.error('Unexpected error  $e-> $s');
      rethrow;
    }
  }

  @override
  Future<List<OrganizationModel>> getOrganization(String orgCode) async {
    try {
      final req = await FirebaseServices.org
          .where("inviteCode", isEqualTo: orgCode)
          .get();
      if (req.docs.isEmpty) return [];

      final org = req.docs
          .map((org) => OrganizationModel.fromFirestore(org))
          .toList();
      return org;
    } on FirebaseException catch (e, s) {
      YoLogger.error('Firestore error $e -> $s');
      return [];
    } catch (e, s) {
      YoLogger.error('Unexpected error  $e-> $s');
      return [];
    }
  }

  @override
  Future<void> joinOrganization(String orgId) async {
    try {
      final memberId = YoIdGenerator.alphanumericId();
      final notifId = YoIdGenerator.alphanumericId();
      final orgSnap = await FirebaseServices.org.doc(orgId).get();
      final org = OrganizationModel.fromFirestore(orgSnap);

      final memberSnap = await FirebaseServices.member
          .where("orgId", isEqualTo: orgId)
          .where("role", isNotEqualTo: MemberRole.member.name)
          .get();
      final uid = memberSnap.docs
          .map((doc) => MemberModel.fromFirestore(doc).uid)
          .toList();
      final playerId = memberSnap.docs
          .map((doc) => MemberModel.fromFirestore(doc).playerId)
          .toList();

      final notif = NotificationsModel(
        id: notifId,
        orgId: org.id,
        uidShows: uid,
        type: NotificationType.orgUserJoined,
        createdAt: DateTime.now(),
        data: NotificationData(userName: user.name, orgName: org.name),
      );

      final member = MemberModel(
        id: memberId,
        uid: user.uid,
        name: user.name,
        email: user.email,
        playerId: user.playerId,
        orgId: orgId,
        role: MemberRole.member,
        imageUrl: user.photoUrl,
      );

      final title = NotificationMessage.title(
        type: NotificationType.orgUserJoined,
      );
      final message = NotificationMessage.description(
        type: NotificationType.orgUserJoined,
        data: NotificationData(userName: user.name, orgName: org.name),
      );

      await NotificationService().sendNotification(
        playerIds: playerId,
        title: title,
        message: message,
      );
      await FirebaseServices.member.doc(memberId).set(member.toJson());
      await FirebaseServices.notif.doc(notifId).set(notif.toJson());
    } on FirebaseException catch (e, s) {
      YoLogger.error('Firestore error $e -> $s');
      rethrow;
    } catch (e, s) {
      YoLogger.error('Unexpected error  $e-> $s');
      rethrow;
    }
  }

  @override
  Future<bool> isJoinOrganization(String orgId) async {
    try {
      final res = await FirebaseServices.member
          .where('uid', isEqualTo: user.uid)
          .where('orgId', isEqualTo: orgId)
          .where('isPending', isEqualTo: false)
          .limit(1) // cukup ambil 1 saja
          .get();

      return res.docs.isNotEmpty; // true kalau ada
    } catch (e) {
      return false;
    }
  }
}
