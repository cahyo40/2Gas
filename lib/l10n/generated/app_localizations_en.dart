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

  @override
  String get onboarding_page1_title => 'All your tasks, in one place.';

  @override
  String get onboarding_page1_subtitle =>
      'Manage to-do lists, projects, and ideas without the fuss. Focus on what matters.';

  @override
  String get onboarding_page1_button => 'Next';

  @override
  String get onboarding_page2_title => 'Collaborate, no drama.';

  @override
  String get onboarding_page2_subtitle =>
      'Create, share, and track tasks with your team — transparent and efficient.';

  @override
  String get onboarding_page2_button => 'Next';

  @override
  String get onboarding_page3_title => 'Productive without stress.';

  @override
  String get onboarding_page3_subtitle =>
      'Track progress, celebrate achievements, and enjoy organized results.';

  @override
  String get onboarding_page3_button => 'Start Now';
}
