import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';

import '../../domain/repositories/task_repository.dart';
import '../datasource/task_network_datasource.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskNetworkDatasource _network;

  TaskRepositoryImpl(this._network);

  @override
  Future<List<ProjectModel>> getProject() async {
    return await _network.getProject();
  }

  @override
  Future<List<TaskModel>> getTask() async {
    return await _network.getTask();
  }
}
