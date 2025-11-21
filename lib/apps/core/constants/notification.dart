import 'package:flutter_dotenv/flutter_dotenv.dart';

class NotificationsConst {
  NotificationsConst._();

  static String get appId =>
      dotenv.env['ONESIGNAL_APP_ID'] ?? ''; // pastikan tidak null

  static String get restApiKey => dotenv.env['ONESIGNAL_REST_API_KEY'] ?? '';
}
