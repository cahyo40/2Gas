import 'package:get/get.dart';
import 'package:twogass/apps/data/model/notifications_model.dart';
import 'package:twogass/apps/features/notifications/domain/usecase/fetch_notifications_usecase.dart';
import 'package:yo_ui/yo_ui_base.dart';

class NotificationsController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();

  FetchNotificationsUsecase fetchNotif = FetchNotificationsUsecase(Get.find());

  RxList<NotificationsModel> notifications = <NotificationsModel>[].obs;
  RxList<NotificationsModel> notificationShow = <NotificationsModel>[].obs;

  initData({bool useLoading = true}) async {
    isLoading.value = useLoading;
    try {
      final res = await Future.wait([fetchNotif()]);
      notifications.value = res[0];
      notificationShow.value = notifications;
    } catch (e) {
      YoLogger.error("Notif Controller Err -> $e");
    } finally {
      isLoading.value = false;
    }
  }
}
