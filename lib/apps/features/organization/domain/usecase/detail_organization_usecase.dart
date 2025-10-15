import 'package:twogass/apps/data/model/organitation_model.dart';

import '../repositories/organization_repository.dart';

class GetOrganizationUsecase {
  final OrganizationRepository _repo;

  GetOrganizationUsecase(this._repo);

  Future<OrganizationModel> call(String orgId) async {
    return await _repo.getOrganization(orgId);
  }
}
