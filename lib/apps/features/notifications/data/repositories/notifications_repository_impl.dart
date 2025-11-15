import 'package:twogass/apps/data/model/notifications_model.dart';

import '../../domain/repositories/notifications_repository.dart';
import '../datasource/notifications_network_datasource.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsNetworkDatasource _network;

  NotificationsRepositoryImpl(this._network);

  @override
  Future<List<NotificationsModel>> getNotification() async {
    return await _network.getNotification();
  }
}
