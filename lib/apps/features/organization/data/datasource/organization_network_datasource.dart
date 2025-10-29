import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twogass/apps/core/services/firebase.dart';
import 'package:twogass/apps/data/model/activity_model.dart';
import 'package:twogass/apps/data/model/member_model.dart';
import 'package:twogass/apps/data/model/organitation_model.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/organization/domain/repositories/organization_repository.dart';

class OrganizationNetworkDatasource implements OrganizationRepository {
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
}
