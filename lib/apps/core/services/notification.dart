import 'package:dio/dio.dart';
import 'package:twogass/apps/core/constants/notification.dart';
import 'package:yo_ui/yo_ui.dart';

class NotificationService {
  final Dio _dio = Dio();
  final String _appId = NotificationsConst.appId;

  Future<void> sendNotification({
    required List<String> playerIds, // Ini adalah OneSignal Player ID
    required String title,
    required String message,
  }) async {
    final url = "https://onesignal.com/api/v1/notifications"; // URL yang benar

    try {
      final response = await _dio.post(
        url,
        options: Options(
          headers: {
            // Format Authorization yang benar
            "Authorization": "Basic ${NotificationsConst.restApiKey}",
            "Content-Type": "application/json; charset=utf-8",
          },
        ),
        data: {
          "app_id": _appId,
          "include_player_ids": [...playerIds],
          "headings": {"en": title},
          "contents": {"en": message},
        },
      );

      YoLogger.debug(
        "Send Notification Success! Status code: ${response.statusCode} ${playerIds.toString()}",
      );
      YoLogger.debug("Response body: ${response.data}");
    } on DioError catch (e) {
      YoLogger.debug("Error Param : ${playerIds.toString()}");
      YoLogger.error("Error sending notification: ${e.response?.statusCode}");
      YoLogger.error("Error response body: ${e.response?.data}");
      // Handle error, misalnya tampilkan snackbar kepada user
    }
  }

  Future<void> sendScheduledNotification({
    required List<String> playerIds,
    required String title,
    required String message,
    required DateTime scheduledTime,
  }) async {
    final url = "https://onesignal.com/api/v1/notifications";

    try {
      final response = await _dio.post(
        url,
        options: Options(
          headers: {
            "Authorization": "Basic ${NotificationsConst.restApiKey}",
            "Content-Type": "application/json; charset=utf-8",
          },
        ),
        data: {
          "app_id": _appId,
          "include_player_ids": [...playerIds],
          "headings": {"en": title},
          "contents": {"en": message},
          // Kunci untuk penjadwalan
          "send_after": scheduledTime.toUtc().toIso8601String(),
        },
      );

      YoLogger.debug(
        "Send Scheduled Notification Success! Status code: ${response.statusCode}",
      );
      YoLogger.debug("Scheduled for: ${scheduledTime.toIso8601String()}");
      YoLogger.debug("Response body: ${response.data}");
    } on DioError catch (e) {
      YoLogger.debug("Error Param : ${playerIds.toString()}");
      YoLogger.error(
        "Error sending scheduled notification: ${e.response?.statusCode}",
      );
      YoLogger.error("Error response body: ${e.response?.data}");
    }
  }
}
