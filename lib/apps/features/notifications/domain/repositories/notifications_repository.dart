import 'package:twogass/apps/data/model/notifications_model.dart';

abstract class NotificationsRepository {
  Future<List<NotificationsModel>> getNotification();
}
