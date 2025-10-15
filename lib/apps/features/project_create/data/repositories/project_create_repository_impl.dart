import '../../domain/repositories/project_create_repository.dart';
import '../datasource/project_create_network_datasource.dart';
import '../datasource/project_create_offline_datasource.dart';

class ProjectCreateRepositoryImpl implements ProjectCreateRepository {
  final ProjectCreateNetworkDatasource _network;
  final ProjectCreateOfflineDatasource _offline;

  ProjectCreateRepositoryImpl(this._network, this._offline);
}
