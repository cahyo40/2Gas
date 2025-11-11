import 'package:twogass/apps/data/model/schedule_model.dart';

import '../../domain/repositories/schedule_repository.dart';
import '../datasource/schedule_network_datasource.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleNetworkDatasource _network;

  ScheduleRepositoryImpl(this._network);

  @override
  Future<List<ScheduleModel>> getSchedule() async {
    return await _network.getSchedule();
  }
}
