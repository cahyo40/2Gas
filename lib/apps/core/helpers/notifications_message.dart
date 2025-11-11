// file: lib/extensions/notification_type_extension.dart (atau path Anda)

import 'package:flutter/material.dart';
import 'package:twogass/apps/data/model/notifications_model.dart'; // Sesuaikan path
import 'package:twogass/l10n/generated/app_localizations.dart'; // Sesuaikan path

/// Helper class untuk mendapatkan deskripsi notifikasi yang sudah dilokalisasi.
class NotificationsMessage {
  /// Membangun dan mengembalikan pesan notifikasi berdasarkan tipe dan data yang diberikan.
  ///
  /// [context] diperlukan untuk mengakses [AppLocalizations].
  /// [type] adalah tipe enum dari notifikasi.
  /// [data] adalah objek [NotificationData] yang berisi parameter dinamis.
  ///
  /// Contoh penggunaan:
  /// ```dart
  /// final message = NotificationsMessage().getDescription(
  ///   context,
  ///   NotificationType.orgUserJoined,
  ///   NotificationData(userName: 'Budi', orgName: 'Flutter Dev'),
  /// );
  /// ```
  String getDescription(
    BuildContext context,
    NotificationType type,
    NotificationData data,
  ) {
    final l10n = AppLocalizations.of(context)!;

    switch (type) {
      case NotificationType.orgAccessRequestApproved:
        return l10n.notif_org_access_request_approved(
          data.orgName ?? 'Organisasi Tidak Diketahui',
        );

      case NotificationType.orgUserJoined:
        return l10n.notif_org_user_joined(
          data.userName ?? 'Seorang pengguna',
          data.orgName ?? 'Organisasi Tidak Diketahui',
        );

      case NotificationType.orgRoleChangedToAdmin:
        return l10n.notif_org_role_changed_to_admin(
          data.orgName ?? 'Organisasi Tidak Diketahui',
        );

      case NotificationType.orgUserRemoved:
        return l10n.notif_org_user_removed(
          data.orgName ?? 'Organisasi Tidak Diketahui',
        );

      case NotificationType.projectUserAdded:
        return l10n.notif_project_user_added(
          data.projectName ?? 'Proyek Tidak Diketahui',
        );

      case NotificationType.projectUserRemoved:
        // BUG FIX: Sebelumnya memanggil notif_org_user_removed
        return l10n.notif_project_user_removed(
          data.projectName ?? 'Proyek Tidak Diketahui',
        );

      case NotificationType.projectDataUpdated:
        return l10n.notif_project_data_updated(
          data.projectName ?? 'Proyek Tidak Diketahui',
        );

      case NotificationType.taskAssigned:
        return l10n.notif_task_assigned(
          data.taskName ?? 'Tugas Baru',
          data.projectName ?? 'Proyek Tidak Diketahui',
        );

      case NotificationType.taskUserUnassigned:
        return l10n.notif_task_user_unassigned(
          data.taskName ?? 'Tugas Tidak Diketahui',
        );

      case NotificationType.taskUpdated:
        return l10n.notif_task_updated(
          data.taskName ?? 'Tugas Tidak Diketahui',
        );

      // Default case untuk tipe yang tidak dikenal
    }
  }
}
