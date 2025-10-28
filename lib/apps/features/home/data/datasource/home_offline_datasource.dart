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

  // TODO: local db / shared pref
}
