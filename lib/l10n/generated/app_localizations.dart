import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// No description provided for @nav_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get nav_home;

  /// No description provided for @nav_task.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get nav_task;

  /// No description provided for @nav_search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get nav_search;

  /// No description provided for @nav_notif.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get nav_notif;

  /// No description provided for @nav_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get nav_settings;

  /// No description provided for @onboarding_page1_title.
  ///
  /// In en, this message translates to:
  /// **'All your tasks, in one place.'**
  String get onboarding_page1_title;

  /// No description provided for @onboarding_page1_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage to-do lists, projects, and ideas without the fuss. Focus on what matters.'**
  String get onboarding_page1_subtitle;

  /// No description provided for @onboarding_page1_button.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboarding_page1_button;

  /// No description provided for @onboarding_page2_title.
  ///
  /// In en, this message translates to:
  /// **'Collaborate, no drama.'**
  String get onboarding_page2_title;

  /// No description provided for @onboarding_page2_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Create, share, and track tasks with your team — transparent and efficient.'**
  String get onboarding_page2_subtitle;

  /// No description provided for @onboarding_page2_button.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboarding_page2_button;

  /// No description provided for @onboarding_page3_title.
  ///
  /// In en, this message translates to:
  /// **'Productive without stress.'**
  String get onboarding_page3_title;

  /// No description provided for @onboarding_page3_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Track progress, celebrate achievements, and enjoy organized results.'**
  String get onboarding_page3_subtitle;

  /// No description provided for @onboarding_page3_button.
  ///
  /// In en, this message translates to:
  /// **'Start Now'**
  String get onboarding_page3_button;

  /// No description provided for @login_title.
  ///
  /// In en, this message translates to:
  /// **'Sign in to 2Gas'**
  String get login_title;

  /// No description provided for @login_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your tasks more easily and efficiently.'**
  String get login_subtitle;

  /// No description provided for @login_button_google.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get login_button_google;

  /// No description provided for @good_morning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get good_morning;

  /// No description provided for @good_afternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get good_afternoon;

  /// No description provided for @good_evening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get good_evening;

  /// No description provided for @good_night.
  ///
  /// In en, this message translates to:
  /// **'Good night'**
  String get good_night;

  /// No description provided for @taskCreated.
  ///
  /// In en, this message translates to:
  /// **'{user} created task {task} in project {project}'**
  String taskCreated(Object project, Object task, Object user);

  /// No description provided for @taskUpdated.
  ///
  /// In en, this message translates to:
  /// **'{user} updated task {task}'**
  String taskUpdated(Object task, Object user);

  /// No description provided for @taskDeleted.
  ///
  /// In en, this message translates to:
  /// **'{user} deleted task {task}'**
  String taskDeleted(Object task, Object user);

  /// No description provided for @taskCompleted.
  ///
  /// In en, this message translates to:
  /// **'{user} completed task {task}'**
  String taskCompleted(Object task, Object user);

  /// No description provided for @taskReopened.
  ///
  /// In en, this message translates to:
  /// **'{user} reopened task {task}'**
  String taskReopened(Object task, Object user);

  /// No description provided for @taskAssigned.
  ///
  /// In en, this message translates to:
  /// **'{user} assigned task {task} to {assignee}'**
  String taskAssigned(Object assignee, Object task, Object user);

  /// No description provided for @taskUnassigned.
  ///
  /// In en, this message translates to:
  /// **'{user} unassigned task {task}'**
  String taskUnassigned(Object task, Object user);

  /// No description provided for @taskMoved.
  ///
  /// In en, this message translates to:
  /// **'{user} moved task {task} to column {column}'**
  String taskMoved(Object column, Object task, Object user);

  /// No description provided for @taskCommented.
  ///
  /// In en, this message translates to:
  /// **'{user} commented on task {task}'**
  String taskCommented(Object task, Object user);

  /// No description provided for @taskAttachmentAdded.
  ///
  /// In en, this message translates to:
  /// **'{user} added attachment to task {task}'**
  String taskAttachmentAdded(Object task, Object user);

  /// No description provided for @taskAttachmentRemoved.
  ///
  /// In en, this message translates to:
  /// **'{user} removed attachment from task {task}'**
  String taskAttachmentRemoved(Object task, Object user);

  /// No description provided for @taskLabelAdded.
  ///
  /// In en, this message translates to:
  /// **'{user} added label {label} to task {task}'**
  String taskLabelAdded(Object label, Object task, Object user);

  /// No description provided for @taskLabelRemoved.
  ///
  /// In en, this message translates to:
  /// **'{user} removed label {label} from task {task}'**
  String taskLabelRemoved(Object label, Object task, Object user);

  /// No description provided for @projectCreated.
  ///
  /// In en, this message translates to:
  /// **'{user} created project {project}'**
  String projectCreated(Object project, Object user);

  /// No description provided for @projectUpdated.
  ///
  /// In en, this message translates to:
  /// **'{user} updated project {project}'**
  String projectUpdated(Object project, Object user);

  /// No description provided for @projectDeleted.
  ///
  /// In en, this message translates to:
  /// **'{user} deleted project {project}'**
  String projectDeleted(Object project, Object user);

  /// No description provided for @projectArchived.
  ///
  /// In en, this message translates to:
  /// **'{user} archived project {project}'**
  String projectArchived(Object project, Object user);

  /// No description provided for @projectRestored.
  ///
  /// In en, this message translates to:
  /// **'{user} restored project {project}'**
  String projectRestored(Object project, Object user);

  /// No description provided for @memberInvited.
  ///
  /// In en, this message translates to:
  /// **'{user} invited {target} to {org}'**
  String memberInvited(Object org, Object target, Object user);

  /// No description provided for @memberJoined.
  ///
  /// In en, this message translates to:
  /// **'{user} joined {org}'**
  String memberJoined(Object org, Object user);

  /// No description provided for @memberRemoved.
  ///
  /// In en, this message translates to:
  /// **'{user} removed {target} from {org}'**
  String memberRemoved(Object org, Object target, Object user);

  /// No description provided for @memberRoleUpdated.
  ///
  /// In en, this message translates to:
  /// **'{user} updated {target}\'s role to {role}'**
  String memberRoleUpdated(Object role, Object target, Object user);

  /// No description provided for @organizationCreated.
  ///
  /// In en, this message translates to:
  /// **'{user} created new organization {org}'**
  String organizationCreated(Object org, Object user);

  /// No description provided for @organizationUpdated.
  ///
  /// In en, this message translates to:
  /// **'{user} updated organization {org}'**
  String organizationUpdated(Object org, Object user);

  /// No description provided for @organizationDeleted.
  ///
  /// In en, this message translates to:
  /// **'{user} deleted organization {org}'**
  String organizationDeleted(Object org, Object user);

  /// No description provided for @organizationJoined.
  ///
  /// In en, this message translates to:
  /// **'{user} joined organization {org}'**
  String organizationJoined(Object org, Object user);

  /// No description provided for @organizationLeft.
  ///
  /// In en, this message translates to:
  /// **'{user} left organization {org}'**
  String organizationLeft(Object org, Object user);

  /// No description provided for @commentAdded.
  ///
  /// In en, this message translates to:
  /// **'{user} added a comment'**
  String commentAdded(Object user);

  /// No description provided for @commentEdited.
  ///
  /// In en, this message translates to:
  /// **'{user} edited a comment'**
  String commentEdited(Object user);

  /// No description provided for @commentDeleted.
  ///
  /// In en, this message translates to:
  /// **'{user} deleted a comment'**
  String commentDeleted(Object user);

  /// No description provided for @attachmentAdded.
  ///
  /// In en, this message translates to:
  /// **'{user} added attachment {file}'**
  String attachmentAdded(Object file, Object user);

  /// No description provided for @attachmentRemoved.
  ///
  /// In en, this message translates to:
  /// **'{user} removed attachment {file}'**
  String attachmentRemoved(Object file, Object user);

  /// No description provided for @labelCreated.
  ///
  /// In en, this message translates to:
  /// **'{user} created new label {label}'**
  String labelCreated(Object label, Object user);

  /// No description provided for @labelUpdated.
  ///
  /// In en, this message translates to:
  /// **'{user} updated label {label}'**
  String labelUpdated(Object label, Object user);

  /// No description provided for @labelDeleted.
  ///
  /// In en, this message translates to:
  /// **'{user} deleted label {label}'**
  String labelDeleted(Object label, Object user);

  /// No description provided for @field_title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get field_title;

  /// No description provided for @field_title_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter a title'**
  String get field_title_hint;

  /// No description provided for @field_description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get field_description;

  /// No description provided for @field_description_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter a description'**
  String get field_description_hint;

  /// No description provided for @field_address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get field_address;

  /// No description provided for @field_address_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter an address'**
  String get field_address_hint;

  /// No description provided for @field_email_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get field_email_hint;

  /// No description provided for @field_category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get field_category;

  /// No description provided for @field_category_msg_required.
  ///
  /// In en, this message translates to:
  /// **'Category is required.'**
  String get field_category_msg_required;

  /// No description provided for @field_categoory_delete_title.
  ///
  /// In en, this message translates to:
  /// **'Delete Category'**
  String get field_categoory_delete_title;

  /// No description provided for @field_categoory_delete_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this category?'**
  String get field_categoory_delete_message;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @field_priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get field_priority;

  /// No description provided for @field_priority_hint.
  ///
  /// In en, this message translates to:
  /// **'Select priority level'**
  String get field_priority_hint;

  /// No description provided for @field_assigns.
  ///
  /// In en, this message translates to:
  /// **'Assignees'**
  String get field_assigns;

  /// No description provided for @select_members.
  ///
  /// In en, this message translates to:
  /// **'Select members'**
  String get select_members;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
