import 'package:twogass/apps/features/home/data/models/organization_home_response.dart';

import '../repositories/home_repository.dart';

class HomeOrgUsecase {
  final HomeRepository _repo;

  HomeOrgUsecase(this._repo);

  Future<List<OrganizationHomeResponseModel>> call() async {
    return await _repo.homeOrganization();
  }
}
