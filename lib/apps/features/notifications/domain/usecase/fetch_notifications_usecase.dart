import 'package:twogass/apps/data/model/notifications_model.dart';

import '../repositories/notifications_repository.dart';

class FetchNotificationsUsecase {
  final NotificationsRepository _repo;

  FetchNotificationsUsecase(this._repo);

  Future<List<NotificationsModel>> call() => _repo.getNotification();
}
