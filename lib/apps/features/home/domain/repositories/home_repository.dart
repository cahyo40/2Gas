import 'package:twogass/apps/data/model/organitation_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/home/data/models/organization_home_response.dart';

abstract class HomeRepository {
  Future<List<OrganizationHomeResponseModel>> homeOrganization();
  Future<List<TaskModel>> userTask();
  Future<List<OrganizationModel>> getOrganization(String orgCode);
  Future<void> joinOrganization(String orgId);
  Future<bool> isJoinOrganization(String orgId);
}
