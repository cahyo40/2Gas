import 'package:twogass/apps/data/model/task_model.dart';

import '../../domain/repositories/task_create_repository.dart';
import '../datasource/task_create_network_datasource.dart';
import '../datasource/task_create_offline_datasource.dart';

class TaskCreateRepositoryImpl implements TaskCreateRepository {
  final TaskCreateNetworkDatasource _network;
  final TaskCreateOfflineDatasource _offline;

  TaskCreateRepositoryImpl(this._network, this._offline);

  @override
  Future<bool> createTask(TaskModel task) async {
    return await _network.createTask(task);
  }
}
