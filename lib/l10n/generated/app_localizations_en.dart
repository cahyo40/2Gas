// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get nav_home => 'Home';

  @override
  String get nav_task => 'Tasks';

  @override
  String get nav_search => 'Search';

  @override
  String get nav_notif => 'Notifications';

  @override
  String get nav_settings => 'Settings';

  @override
  String get login_headline => 'Hey there! 👋 Ready to organize your day?';

  @override
  String get login_support => 'One tap and you’re in—no fuss.';

  @override
  String get login_btn => 'Sign in with Google →';
}
