import '../../domain/repositories/task_repository.dart';
import '../datasource/task_network_datasource.dart';
import '../datasource/task_offline_datasource.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskNetworkDatasource _network;
  final TaskOfflineDatasource _offline;

  TaskRepositoryImpl(this._network, this._offline);
}
