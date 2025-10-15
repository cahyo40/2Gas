import 'package:twogass/apps/data/model/activity_model.dart';

import '../repositories/organization_repository.dart';

class DetailActivityUsecase {
  final OrganizationRepository _repo;

  DetailActivityUsecase(this._repo);

  Future<List<ActivityModel>> call(String orgId) async {
    return await _repo.getActivity(orgId);
  }
}
