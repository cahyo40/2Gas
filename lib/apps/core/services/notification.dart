import 'package:dio/dio.dart';
import 'package:twogass/apps/core/constants/notification.dart';
import 'package:yo_ui/yo_ui.dart';

class NotificationService {
  final Dio _dio = Dio();
  final String _restKey = NotificationsConst.apiKey;
  final String _appId = NotificationsConst.appId;

  Future<void> sendNotification({
    required List<String> playerIds,
    required String title,
    required String message,
  }) async {
    final response = await _dio.post(
      "https://onesignal.com/api/v1/notifications",
      options: Options(
        headers: {
          "Authorization": "Basic $_restKey",
          "Content-Type": "application/json",
        },
      ),
      data: {
        "app_id": _appId,
        "include_player_ids": playerIds,
        "headings": {"en": title},
        "contents": {"en": message},
      },
    );
    YoLogger.debug("Send Notification code : ${response.statusCode}");
  }
}
