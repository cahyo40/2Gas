import 'package:twogass/apps/core/services/firebase.dart';
import 'package:twogass/apps/data/model/activity_model.dart';
import 'package:twogass/apps/data/model/organitation_model.dart';
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
          .orderBy("createdAt", descending: false)
          .get();
      return data.docs
          .map((docs) => ActivityModel.fromFirestore(docs))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
