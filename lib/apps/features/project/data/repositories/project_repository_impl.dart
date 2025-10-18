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
}
