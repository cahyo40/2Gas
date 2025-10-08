import '../../domain/repositories/settings_repository.dart';
import '../datasource/settings_network_datasource.dart';
import '../datasource/settings_offline_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsNetworkDatasource _network;
  final SettingsOfflineDatasource _offline;

  SettingsRepositoryImpl(this._network, this._offline);
}
