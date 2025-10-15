import 'package:twogass/apps/data/model/activity_model.dart';
import 'package:twogass/apps/data/model/organitation_model.dart';

abstract class OrganizationRepository {
  Future<OrganizationModel> getOrganization(String orgId);
  Future<List<ActivityModel>> getActivity(String orgId);
}
