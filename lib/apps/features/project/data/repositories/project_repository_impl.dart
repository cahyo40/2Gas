import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';

import '../../domain/repositories/project_repository.dart';
import '../datasource/project_network_datasource.dart';
import '../datasource/project_offline_datasource.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectNetworkDatasource _network;
  final ProjectOfflineDatasource _offline;

  ProjectRepositoryImpl(this._network, this._offline);

  @override
  Future<Map<String, dynamic>> projectResponse({
    required String id,
    String? orgId,
  }) async {
    return await _network.projectResponse(id: id, orgId: orgId);
  }

  @override
  Future<void> updateTaskStatus({
    required taskId,
    required String projectId,
    required TaskStatus status,
  }) async {
    return await _network.updateTaskStatus(
      taskId: taskId,
      projectId: projectId,
      status: status,
    );
  }

  @override
  Future<void> addAssigner({required ProjectAssignModel model}) async {
    return await _network.addAssigner(model: model);
  }

  @override
  Future<void> updateProject(ProjectModel model) async {
    return await _network.updateProject(model);
  }
}
