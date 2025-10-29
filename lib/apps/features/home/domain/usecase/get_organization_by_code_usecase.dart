import 'package:twogass/apps/data/model/organitation_model.dart';
import 'package:twogass/apps/features/home/domain/repositories/home_repository.dart';

class GetOrganizationByCodeUsecase {
  final HomeRepository _r;
  GetOrganizationByCodeUsecase(this._r);

  Future<List<OrganizationModel>> call(String orgCode) =>
      _r.getOrganization(orgCode);
}
