import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/data/model/notifications_model.dart';

class NotificationMessage {
  NotificationMessage._();
  static String description({
    required NotificationType type,
    required NotificationData data,
  }) {
    switch (type) {
      case NotificationType.orgAccessRequestApproved:
        return L10n.t.notif_org_access_request_approved(
          data.orgName ?? "Organization",
        );
      case NotificationType.orgUserJoined:
        return L10n.t.notif_org_user_joined(
          data.userName ?? "Username",
          data.orgName ?? "Organization",
        );
      case NotificationType.orgRoleChangedToAdmin:
        return L10n.t.notif_org_role_changed_to_admin(
          data.orgName ?? "Organization",
        );
      case NotificationType.orgUserRemoved:
        return L10n.t.notif_org_user_removed(data.orgName ?? "Organization");
      case NotificationType.projectUserAdded:
        return L10n.t.notif_project_user_added(data.projectName ?? "Project");
      case NotificationType.projectUserRemoved:
        return L10n.t.notif_project_user_removed(data.projectName ?? "Project");
      case NotificationType.projectDataUpdated:
        return L10n.t.notif_project_data_updated(data.projectName ?? "Project");
      case NotificationType.taskAssigned:
        return L10n.t.notif_task_assigned(
          data.taskName ?? "Task",
          data.projectName ?? "Project",
        );
      case NotificationType.taskUserUnassigned:
        return L10n.t.notif_task_user_unassigned(data.taskName ?? "Task");
      case NotificationType.taskUpdated:
        return L10n.t.notif_task_updated(data.taskName ?? "Task");
      case NotificationType.taskDeleted:
        return L10n.t.notif_task_deleted_description(data.taskName ?? "Task");
    }
  }

  static String title({required NotificationType type}) {
    switch (type) {
      case NotificationType.orgAccessRequestApproved:
        return L10n.t.notif_org_access_request_approved_title;
      case NotificationType.orgUserJoined:
        return L10n.t.notif_org_user_request_joined_title;
      case NotificationType.orgRoleChangedToAdmin:
        return L10n.t.notif_org_role_changed_to_admin_title;
      case NotificationType.orgUserRemoved:
        return L10n.t.notif_org_user_removed_title;
      case NotificationType.projectUserAdded:
        return L10n.t.notif_project_user_added_title;
      case NotificationType.projectUserRemoved:
        return L10n.t.notif_project_user_removed_title;
      case NotificationType.projectDataUpdated:
        return L10n.t.notif_project_data_updated_title;
      case NotificationType.taskAssigned:
        return L10n.t.notif_task_assigned_title;
      case NotificationType.taskUserUnassigned:
        return L10n.t.notif_task_user_unassigned_title;
      case NotificationType.taskUpdated:
        return L10n.t.notif_task_updated_title;

      case NotificationType.taskDeleted:
        return L10n.t.notif_task_deleted_title;
    }
  }
}
