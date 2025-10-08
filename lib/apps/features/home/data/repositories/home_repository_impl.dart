import '../../domain/repositories/home_repository.dart';
import '../datasource/home_network_datasource.dart';
import '../datasource/home_offline_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeNetworkDatasource _network;
  final HomeOfflineDatasource _offline;

  HomeRepositoryImpl(this._network, this._offline);
}
