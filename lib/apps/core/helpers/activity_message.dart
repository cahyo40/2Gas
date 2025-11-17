import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/data/model/activity_model.dart';

class ActivityMessageHelper {
  static String title({required ActivityType type}) {
    switch (type) {
      // MEMBER
      case ActivityType.memberChangeRole:
        return L10n.t.activity_member_change_role;
      case ActivityType.memberJoin:
        return L10n.t.activity_member_join_title;
      case ActivityType.memberLeft:
        return L10n.t.activity_member_left_title;
      case ActivityType.memberRemoved:
        return L10n.t.activity_member_remove_title;

      // ORG
      case ActivityType.organizationCreated:
        return L10n.t.activity_org_created_title;
      case ActivityType.organizationUpdated:
        return L10n.t.activity_org_updated_title;
      // Project
      case ActivityType.projectComment:
        return L10n.t.activity_project_comment_title;
      case ActivityType.projectCompleted:
        return L10n.t.activity_project_completed_title;
      case ActivityType.projectCreated:
        return L10n.t.activity_project_created_title;
      case ActivityType.projectDeleted:
        return L10n.t.activity_project_deleted_title;
      case ActivityType.projectUpdated:
        return L10n.t.activity_project_updated_title;

      // TASK
      case ActivityType.taskCreated:
        return L10n.t.activity_task_created_title;
      case ActivityType.taskDeleted:
        return L10n.t.activity_task_deleted_title;
      case ActivityType.taskMoved:
        return L10n.t.activity_task_moved_title;
      case ActivityType.taskUpdated:
        return L10n.t.activity_task_updated_title;
      // SCHEDULE
      case ActivityType.scheduleCanceled:
        return L10n.t.activity_schedule_deleted_title;
      case ActivityType.scheduleCreated:
        return L10n.t.activity_schedule_created_title;
      case ActivityType.scheduleEdited:
        return L10n.t.activity_schedule_edited_title;
    }
  }

  static String description({
    required ActivityType type,
    required ActivityMeta data,
  }) {
    switch (type) {
      // MEMBER
      case ActivityType.memberChangeRole:
        return L10n.t.activity_member_change_role_desc(
          data.user ?? "User",
          data.info ?? "",
        );
      case ActivityType.memberJoin:
        return L10n.t.activity_member_join_desc(
          data.user ?? "User",
          data.orgName ?? "",
        );
      case ActivityType.memberLeft:
        return L10n.t.activity_member_left_desc(data.user ?? "User");
      case ActivityType.memberRemoved:
        return L10n.t.activity_member_remove_desc(
          data.user ?? "User",
          data.info ?? "",
        );

      // ORG
      case ActivityType.organizationCreated:
        return L10n.t.activity_org_created_desc(
          data.user ?? "User",
          data.orgName ?? "",
        );
      case ActivityType.organizationUpdated:
        return L10n.t.activity_org_updated_desc(
          data.user ?? "User",
          data.info ?? "",
        );
      // Project
      case ActivityType.projectComment:
        return L10n.t.activity_project_comment_desc(
          data.user ?? "User",
          data.projectName ?? "",
          data.info ?? "",
        );
      case ActivityType.projectCompleted:
        return L10n.t.activity_project_completed_desc(data.info ?? "");
      case ActivityType.projectCreated:
        return L10n.t.activity_project_created_desc(
          data.user ?? "User",
          data.projectName ?? "",
        );
      case ActivityType.projectDeleted:
        return L10n.t.activity_project_deleted_desc(
          data.user ?? "User",
          data.info ?? "",
          data.projectName ?? "",
        );
      case ActivityType.projectUpdated:
        return L10n.t.activity_project_updated_desc(
          data.user ?? "User",
          data.info ?? "",
        );

      // TASK
      case ActivityType.taskCreated:
        return L10n.t.activity_task_created_desc(
          data.user ?? "User",
          data.taskName ?? "",
          data.projectName ?? "",
        );
      case ActivityType.taskDeleted:
        return L10n.t.activity_task_deleted_desc(
          data.user ?? "User",
          data.taskName ?? "",
          data.projectName ?? "",
        );
      case ActivityType.taskMoved:
        return L10n.t.activity_task_move_desc(
          data.user ?? "User",
          data.taskName ?? "",
          data.info ?? "",
        );
      case ActivityType.taskUpdated:
        return L10n.t.activity_task_updated_desc(
          data.user ?? "User",
          data.taskName ?? "",
          data.info ?? "",
        );
      // SCHEDULE
      case ActivityType.scheduleCanceled:
        return L10n.t.activity_schedule_deleted_desc(
          data.user ?? "User",
          data.scheduleName ?? "",
        );
      case ActivityType.scheduleCreated:
        return L10n.t.activity_schedule_created_desc(
          data.user ?? "User",
          data.scheduleName ?? "",
        );
      case ActivityType.scheduleEdited:
        return L10n.t.activity_schedule_edited_desc(
          data.user ?? "User",
          data.scheduleName ?? "",
          data.info ?? "",
        );
    }
  }
}
