import 'package:twogass/apps/data/model/member_model.dart';
import 'package:twogass/apps/features/organization/domain/repositories/organization_repository.dart';

class KickMemberUsecase {
  final OrganizationRepository _r;
  KickMemberUsecase(this._r);

  Future<void> call(MemberModel member, {required bool isKick}) =>
      _r.memberOut(member, isKick: isKick);
}
