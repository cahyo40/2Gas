import '../../domain/repositories/project_repository.dart';
import '../datasource/project_network_datasource.dart';
import '../datasource/project_offline_datasource.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectNetworkDatasource _network;
  final ProjectOfflineDatasource _offline;

  ProjectRepositoryImpl(this._network, this._offline);
}
