import 'package:twogass/apps/data/model/schedule_model.dart';
import 'package:twogass/apps/features/schedule/domain/repositories/schedule_repository.dart';

class FetchScheduleUserUsecase {
  final ScheduleRepository _r;
  FetchScheduleUserUsecase(this._r);

  Future<List<ScheduleModel>> call() => _r.getSchedule();
}
