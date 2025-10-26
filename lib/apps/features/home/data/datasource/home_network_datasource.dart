import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/core/services/firebase.dart';
import 'package:twogass/apps/data/model/member_model.dart';
import 'package:twogass/apps/data/model/organitation_model.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/home/data/models/organization_home_response.dart';
import 'package:twogass/apps/features/home/domain/repositories/home_repository.dart';
import 'package:yo_ui/yo_ui.dart';

class HomeNetworkDatasource implements HomeRepository {
  final user = Get.find<AuthController>();
  @override
  Future<List<OrganizationHomeResponseModel>> homeOrganization() async {
    try {
      final myOrg = await FirebaseServices.member
          .where("uid", isEqualTo: user.uid)
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
      final taskId = myTask.docs
          .map((d) => d['taskId'] as String)
          .toSet()
          .toList();
      if (taskId.isEmpty) return [];
      final data = taskId.map((id) async {
        final taskSnap = await FirebaseServices.task.doc(id).get();
        final taskModel = TaskModel.fromFirestore(taskSnap);
        return taskModel;
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
}
