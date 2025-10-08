import '../../domain/repositories/notifications_repository.dart';
import '../datasource/notifications_network_datasource.dart';
import '../datasource/notifications_offline_datasource.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsNetworkDatasource _network;
  final NotificationsOfflineDatasource _offline;

  NotificationsRepositoryImpl(this._network, this._offline);
}
