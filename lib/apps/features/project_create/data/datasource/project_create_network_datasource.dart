import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/core/constants/database.dart';
import 'package:twogass/apps/core/services/firebase.dart';
import 'package:twogass/apps/data/model/activity_model.dart';
import 'package:twogass/apps/data/model/member_model.dart';
import 'package:twogass/apps/data/model/project_category_model.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/features/project_create/domain/repositories/project_create_repository.dart';
import 'package:yo_ui/yo_ui.dart';

class ProjectCreateNetworkDatasource implements ProjectCreateRepository {
  final key = DatabaseConst();
  final user = Get.find<AuthController>();

  @override
  Future<void> createCategory(ProjectCategoryModel categories) async {
    try {
      final check = await FirebaseServices.category.doc(categories.id).get();
      if (!check.exists) {
        await FirebaseServices.category
            .doc(categories.id)
            .set(categories.toJson());
      }
    } on FirebaseException catch (e, s) {
      YoLogger.error('Firestore error $e -> $s');
    } catch (e, s) {
      YoLogger.error('Unexpected error  $e-> $s');
    }
  }

  @override
  Future<Map<String, dynamic>> getMemberCategory(String orgId) async {
    try {
      final member = await FirebaseServices.member
          .where("orgId", isEqualTo: orgId)
          .get();
      final cat = await FirebaseServices.category
          .where("orgId", isEqualTo: orgId)
          .get();

      final dataMember = member.docs
          .map((docs) => MemberModel.fromFirestore(docs))
          .toList();
      final dataCat = cat.docs
          .map((docs) => ProjectCategoryModel.fromFirestore(docs))
          .toList();

      return {key.member: dataMember, key.category: dataCat};
    } on FirebaseException catch (e, s) {
      YoLogger.error('Firestore error $e -> $s');
      return {};
    } catch (e, s) {
      YoLogger.error('Unexpected error  $e-> $s');
      return {};
    }
  }

  @override
  Future<bool> submitProject(ProjectModel project) async {
    try {
      final idActivity = YoIdGenerator.alphanumericId();
      final activity = ActivityModel(
        id: idActivity,
        orgId: project.orgId,
        title: "Create Project",
        description: "",
        type: ActivityType.projectCreated,
        createdAt: project.createdAt,
        meta: ActivityMeta(
          projectName: project.name,
          organizationName: user.name,
        ),
      );

      await FirebaseServices.project.doc(project.id).set(project.toJson());

      await Future.wait(
        project.assign.map(
          (a) => FirebaseServices.projectAssign.doc(a.id).set(a.toJson()),
        ),
      );

      await Future.wait(
        project.categories.map((cat) async {
          final snap = await FirebaseServices.category.doc(cat.id).get();
          if (!snap.exists) {
            await FirebaseServices.category.doc(cat.id).set(cat.toJson());
          }
        }),
      );
      await FirebaseServices.activity.doc(activity.id).set(activity.toJson());

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
