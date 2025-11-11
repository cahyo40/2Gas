import 'package:twogass/apps/data/model/schedule_model.dart';

abstract class ScheduleRepository {
  Future<List<ScheduleModel>> getSchedule();
}
