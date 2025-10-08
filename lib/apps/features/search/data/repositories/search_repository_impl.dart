import '../../domain/repositories/search_repository.dart';
import '../datasource/search_network_datasource.dart';
import '../datasource/search_offline_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchNetworkDatasource _network;
  final SearchOfflineDatasource _offline;

  SearchRepositoryImpl(this._network, this._offline);
}
