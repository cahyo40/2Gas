import 'package:twogass/apps/data/model/organitation_model.dart';
import 'package:twogass/apps/features/organization/domain/repositories/organization_repository.dart';

class DeleteOrgUsecase {
  final OrganizationRepository _r;
  DeleteOrgUsecase(this._r);

  Future<void> call(OrganizationModel model) => _r.deleteOrg(model);
}
