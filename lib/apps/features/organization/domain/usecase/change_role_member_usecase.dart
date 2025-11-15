import 'package:twogass/apps/data/model/member_model.dart';
import 'package:twogass/apps/features/organization/domain/repositories/organization_repository.dart';

class ChangeRoleMemberUsecase {
  final OrganizationRepository _r;
  ChangeRoleMemberUsecase(this._r);

  Future<void> call(MemberModel member, MemberRole role) =>
      _r.changeRoleMember(member, role);
}
