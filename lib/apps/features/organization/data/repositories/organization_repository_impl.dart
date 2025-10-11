import '../../domain/repositories/organization_repository.dart';
import '../datasource/organization_network_datasource.dart';
import '../datasource/organization_offline_datasource.dart';

class OrganizationRepositoryImpl implements OrganizationRepository {
  final OrganizationNetworkDatasource _network;
  final OrganizationOfflineDatasource _offline;

  OrganizationRepositoryImpl(this._network, this._offline);
}
