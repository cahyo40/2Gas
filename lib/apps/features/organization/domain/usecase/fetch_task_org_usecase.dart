import 'package:twogass/apps/data/model/task_model.dart';

import '../repositories/organization_repository.dart';

class FetchTaskOrgUsecase {
  final OrganizationRepository _repo;

  FetchTaskOrgUsecase(this._repo);

  Future<List<TaskModel>> call(String orgId, String? projectId) async {
    return await _repo.getTask(orgId, projectId);
  }
}
