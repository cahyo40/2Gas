import 'package:twogass/apps/data/model/member_model.dart';
import 'package:twogass/apps/features/organization/domain/repositories/organization_repository.dart';

class AcceptMemberUsecase {
  final OrganizationRepository _r;
  AcceptMemberUsecase(this._r);

  Future<void> call(MemberModel member) => _r.acceptMember(member);
}
