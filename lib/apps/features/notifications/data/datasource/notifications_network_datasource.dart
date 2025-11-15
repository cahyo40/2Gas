import 'package:get/get.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/core/services/firebase.dart';
import 'package:twogass/apps/data/model/notifications_model.dart';
import 'package:twogass/apps/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:yo_ui/yo_ui_base.dart';

class NotificationsNetworkDatasource implements NotificationsRepository {
  String get uid => Get.find<AuthController>().uid;
  @override
  Future<List<NotificationsModel>> getNotification() async {
    try {
      final res = await FirebaseServices.notif
          .where("uidShows", arrayContains: uid)
          .orderBy("createdAt", descending: true)
          .get();
      final data = res.docs
          .map((doc) => NotificationsModel.fromFirestore(doc))
          .toList();
      return data;
    } catch (e, s) {
      YoLogger.error("Get Schedule => $e -> $s");
      return [];
    }
  }
}
