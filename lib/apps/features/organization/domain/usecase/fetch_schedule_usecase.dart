import 'package:twogass/apps/data/model/schedule_model.dart';
import 'package:twogass/apps/features/organization/domain/repositories/organization_repository.dart';

class FetchScheduleUsecase {
  final OrganizationRepository _r;
  FetchScheduleUsecase(this._r);

  Future<List<ScheduleModel>> call(String orgId) => _r.getSchedule(orgId);
}
