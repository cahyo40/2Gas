import 'package:twogass/apps/data/model/member_model.dart';
import 'package:twogass/apps/features/organization/domain/repositories/organization_repository.dart';

class FetchMemberOrgUsecase {
  final OrganizationRepository _r;
  FetchMemberOrgUsecase(this._r);

  Future<List<MemberModel>> call(String orgId) => _r.getMember(orgId);
}
