import 'package:twogass/apps/data/model/project_model.dart';

import '../repositories/organization_repository.dart';

class FetchProjectOrgUsecase {
  final OrganizationRepository _repo;

  FetchProjectOrgUsecase(this._repo);

  Future<List<ProjectModel>> call(String orgId) async {
    return await _repo.getProject(orgId);
  }
}
