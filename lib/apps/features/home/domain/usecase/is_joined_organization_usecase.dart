import 'package:twogass/apps/features/home/domain/repositories/home_repository.dart';

class IsJoinedOrganizationUsecase {
  final HomeRepository _r;
  IsJoinedOrganizationUsecase(this._r);

  Future<bool> call(String orgId) => _r.isJoinOrganization(orgId);
}
