import 'package:twogass/apps/data/model/organitation_model.dart';

import '../repositories/organization_create_update_repository.dart';

class OrganizationCreateUpdateUsecase {
  final OrganizationCreateUpdateRepository _repo;

  OrganizationCreateUpdateUsecase(this._repo);

  Future<bool> call(OrganizationModel model) async {
    return _repo.createOrganization(model);
  }
}
