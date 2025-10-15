import 'package:flutter/material.dart';
import 'package:twogass/apps/data/model/activity_model.dart';
import 'package:twogass/l10n/generated/app_localizations.dart';

class ActivityMessageHelper {
  static String getActivityMessage(
    BuildContext context,
    ActivityType type,
    ActivityMeta meta,
  ) {
    final l10n = AppLocalizations.of(context)!;

    switch (type) {
      // 🟦 TASK
      case ActivityType.taskCreated:
        return l10n.taskCreated(
          meta.taskName ?? '',
          meta.projectName ?? '',
          meta.memberName ?? '',
        );
      case ActivityType.taskUpdated:
        return l10n.taskUpdated(meta.taskName ?? '', meta.projectName ?? '');
      case ActivityType.taskCompleted:
        return l10n.taskCompleted(meta.taskName ?? '', meta.projectName ?? '');
      case ActivityType.taskDeleted:
        return l10n.taskDeleted(meta.taskName ?? '', meta.projectName ?? '');
      case ActivityType.taskAssigned:
        return l10n.taskAssigned(
          meta.taskName ?? '',
          meta.memberName ?? '',
          meta.projectName ?? '',
        );
      case ActivityType.taskMoved:
        return l10n.taskMoved(
          meta.taskName ?? '',
          meta.projectName ?? '',
          meta.memberName ?? '',
        );
      case ActivityType.taskCommented:
        return l10n.taskCommented(meta.taskName ?? '', meta.memberName ?? '');

      case ActivityType.projectCreated:
        return l10n.projectCreated(
          meta.projectName ?? '',
          meta.organizationName ?? '',
        );
      case ActivityType.projectUpdated:
        return l10n.projectUpdated(
          meta.projectName ?? '',
          meta.organizationName ?? '',
        );
      case ActivityType.projectDeleted:
        return l10n.projectDeleted(
          meta.projectName ?? '',
          meta.organizationName ?? '',
        );

      case ActivityType.memberInvited:
        return l10n.memberInvited(
          meta.memberName ?? '',
          meta.projectName ?? '',
          meta.organizationName ?? '',
        );
      case ActivityType.memberRemoved:
        return l10n.memberRemoved(
          meta.memberName ?? '',
          meta.projectName ?? '',
          meta.organizationName ?? '',
        );

      // 🟪 ORGANIZATION
      case ActivityType.organizationCreated:
        return l10n.organizationCreated(
          meta.organizationName ?? '',
          meta.memberName ?? '',
        );
      case ActivityType.organizationUpdated:
        return l10n.organizationUpdated(
          meta.organizationName ?? '',
          meta.memberName ?? '',
        );
      case ActivityType.organizationJoined:
        return l10n.organizationJoined(
          meta.organizationName ?? '',
          meta.memberName ?? '',
        );
      case ActivityType.organizationLeft:
        return l10n.organizationLeft(
          meta.organizationName ?? '',
          meta.memberName ?? '',
        );

      // 🟦 COMMENT
      case ActivityType.commentAdded:
        return l10n.commentAdded(meta.memberName ?? '');

      // 🟨 ATTACHMENT
      case ActivityType.attachmentAdded:
        return l10n.attachmentAdded(
          meta.attachmentName ?? '',
          meta.taskName ?? '',
        );
      case ActivityType.attachmentRemoved:
        return l10n.attachmentRemoved(
          meta.attachmentName ?? '',
          meta.taskName ?? '',
        );

      // 🟧 LABEL
      case ActivityType.labelCreated:
        return l10n.labelCreated(meta.labelName ?? '', meta.projectName ?? '');
      case ActivityType.labelDeleted:
        return l10n.labelDeleted(meta.labelName ?? '', meta.projectName ?? '');

      default:
        return "No Activity";
    }
  }
}
