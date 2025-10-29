import 'package:twogass/apps/data/model/organitation_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/home/data/models/organization_home_response.dart';
import 'package:twogass/apps/features/home/domain/repositories/home_repository.dart';

class HomeOfflineDatasource implements HomeRepository {
  @override
  Future<List<OrganizationHomeResponseModel>> homeOrganization() {
    // TODO: implement homeOrganization
    throw UnimplementedError();
  }

  @override
  Future<List<TaskModel>> homeTasks() {
    // TODO: implement homeTasks
    throw UnimplementedError();
  }

  @override
  Future<List<TaskModel>> userTask() {
    // TODO: implement userTask
    throw UnimplementedError();
  }

  @override
  Future<List<OrganizationModel>> getOrganization(String orgCode) {
    // TODO: implement getOrganization
    throw UnimplementedError();
  }

  @override
  Future<void> joinOrganization(String orgId) {
    // TODO: implement joinOrganization
    throw UnimplementedError();
  }

  @override
  Future<bool> isJoinOrganization(String orgId) {
    // TODO: implement isJoinOrganization
    throw UnimplementedError();
  }

  // TODO: local db / shared pref
}
