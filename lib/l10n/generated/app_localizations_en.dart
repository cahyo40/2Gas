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

  @override
  String get login_title => 'Sign in to 2Gas';

  @override
  String get login_subtitle => 'Manage your tasks more easily and efficiently.';

  @override
  String get login_button_google => 'Continue with Google';

  @override
  String get good_morning => 'Good morning';

  @override
  String get good_afternoon => 'Good afternoon';

  @override
  String get good_evening => 'Good evening';

  @override
  String get good_night => 'Good night';

  @override
  String taskCreated(Object project, Object task, Object user) {
    return '$user created task $task in project $project';
  }

  @override
  String taskUpdated(Object task, Object user) {
    return '$user updated task $task';
  }

  @override
  String taskDeleted(Object task, Object user) {
    return '$user deleted task $task';
  }

  @override
  String taskCompleted(Object task, Object user) {
    return '$user completed task $task';
  }

  @override
  String taskReopened(Object task, Object user) {
    return '$user reopened task $task';
  }

  @override
  String taskAssigned(Object assignee, Object task, Object user) {
    return '$user assigned task $task to $assignee';
  }

  @override
  String taskUnassigned(Object task, Object user) {
    return '$user unassigned task $task';
  }

  @override
  String taskMoved(Object column, Object task, Object user) {
    return '$user moved task $task to column $column';
  }

  @override
  String taskCommented(Object task, Object user) {
    return '$user commented on task $task';
  }

  @override
  String taskAttachmentAdded(Object task, Object user) {
    return '$user added attachment to task $task';
  }

  @override
  String taskAttachmentRemoved(Object task, Object user) {
    return '$user removed attachment from task $task';
  }

  @override
  String taskLabelAdded(Object label, Object task, Object user) {
    return '$user added label $label to task $task';
  }

  @override
  String taskLabelRemoved(Object label, Object task, Object user) {
    return '$user removed label $label from task $task';
  }

  @override
  String projectCreated(Object project, Object user) {
    return '$user created project $project';
  }

  @override
  String projectUpdated(Object project, Object user) {
    return '$user updated project $project';
  }

  @override
  String projectDeleted(Object project, Object user) {
    return '$user deleted project $project';
  }

  @override
  String projectArchived(Object project, Object user) {
    return '$user archived project $project';
  }

  @override
  String projectRestored(Object project, Object user) {
    return '$user restored project $project';
  }

  @override
  String memberInvited(Object org, Object target, Object user) {
    return '$user invited $target to $org';
  }

  @override
  String memberJoined(Object org, Object user) {
    return '$user joined $org';
  }

  @override
  String memberRemoved(Object org, Object target, Object user) {
    return '$user removed $target from $org';
  }

  @override
  String memberRoleUpdated(Object role, Object target, Object user) {
    return '$user updated $target\'s role to $role';
  }

  @override
  String organizationCreated(Object org, Object user) {
    return '$user created new organization $org';
  }

  @override
  String organizationUpdated(Object org, Object user) {
    return '$user updated organization $org';
  }

  @override
  String organizationDeleted(Object org, Object user) {
    return '$user deleted organization $org';
  }

  @override
  String organizationJoined(Object org, Object user) {
    return '$user joined organization $org';
  }

  @override
  String organizationLeft(Object org, Object user) {
    return '$user left organization $org';
  }

  @override
  String commentAdded(Object user) {
    return '$user added a comment';
  }

  @override
  String commentEdited(Object user) {
    return '$user edited a comment';
  }

  @override
  String commentDeleted(Object user) {
    return '$user deleted a comment';
  }

  @override
  String attachmentAdded(Object file, Object user) {
    return '$user added attachment $file';
  }

  @override
  String attachmentRemoved(Object file, Object user) {
    return '$user removed attachment $file';
  }

  @override
  String labelCreated(Object label, Object user) {
    return '$user created new label $label';
  }

  @override
  String labelUpdated(Object label, Object user) {
    return '$user updated label $label';
  }

  @override
  String labelDeleted(Object label, Object user) {
    return '$user deleted label $label';
  }

  @override
  String get field_title => 'Title';

  @override
  String get field_title_hint => 'Enter a title';

  @override
  String get field_description => 'Description';

  @override
  String get field_description_hint => 'Enter a description';

  @override
  String get field_address => 'Address';

  @override
  String get field_address_hint => 'Enter an address';

  @override
  String get field_email_hint => 'Enter your email';

  @override
  String get field_category => 'Category';

  @override
  String get field_category_msg_required => 'Category is required.';

  @override
  String get field_categoory_delete_title => 'Delete Category';

  @override
  String get field_categoory_delete_message =>
      'Are you sure you want to delete this category?';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';

  @override
  String get field_priority => 'Priority';

  @override
  String get field_priority_hint => 'Select priority level';

  @override
  String get field_assigns => 'Assignees';

  @override
  String get select_members => 'Select members';
}
