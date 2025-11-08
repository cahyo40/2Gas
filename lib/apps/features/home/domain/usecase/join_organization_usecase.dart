import 'package:twogass/apps/features/home/domain/repositories/home_repository.dart';

class JoinOrganizationUsecase {
  final HomeRepository _repo;
  JoinOrganizationUsecase(this._repo);

  Future<void> call(String orgId) => _repo.joinOrganization(orgId);
}
