// notifications_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

// lib/models/notification_type.dart

enum NotificationType {
  // Organisasi
  orgAccessRequestApproved,
  orgUserJoined,
  orgRoleChangedToAdmin,
  orgUserRemoved,

  // Proyek
  projectUserAdded,
  projectUserRemoved,
  projectDataUpdated,

  // Tugas
  taskAssigned,
  taskUserUnassigned,
  taskUpdated,
  taskDeleted;

  /// Key untuk file .arb (localization)
  /// Format: notif_[kategori]_[aksi]
  String get key {
    switch (this) {
      // Organisasi
      case NotificationType.orgAccessRequestApproved:
        return 'notif_org_access_request_approved';
      case NotificationType.orgUserJoined:
        return 'notif_org_user_joined';
      case NotificationType.orgRoleChangedToAdmin:
        return 'notif_org_role_changed_to_admin';
      case NotificationType.orgUserRemoved:
        return 'notif_org_user_removed';

      // Proyek
      case NotificationType.projectUserAdded:
        return 'notif_project_user_added';
      case NotificationType.projectUserRemoved:
        return 'notif_project_user_removed';
      case NotificationType.projectDataUpdated:
        return 'notif_project_data_updated';

      // Tugas
      case NotificationType.taskAssigned:
        return 'notif_task_assigned';
      case NotificationType.taskUserUnassigned:
        return 'notif_task_user_unassigned';
      case NotificationType.taskUpdated:
        return 'notif_task_updated';
      case NotificationType.taskDeleted:
        return 'notif_task_deleted';
    }
  }
}

class NotificationsModel {
  final String id;

  final List<String> uidShows;
  final NotificationType type;
  final DateTime createdAt;
  final NotificationData data;
  final String? orgId;
  final String? projectId;
  final String? taskId;

  const NotificationsModel({
    required this.id,

    required this.uidShows,
    required this.type,
    required this.createdAt,
    required this.data,
    this.orgId,
    this.projectId,
    this.taskId,
  });

  // ---------- JSON ----------
  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        id: json['id'] as String,

        uidShows: List<String>.from(json['uidShows'] as List),
        type: NotificationType.values.firstWhere(
          (e) => e.name == json['type'] as String,
        ),
        createdAt: DateTime.parse(json['createdAt'] as String),
        data: NotificationData.fromJson(json['data'] as Map<String, dynamic>),
        orgId: json['orgId'] as String?,
        projectId: json['projectId'] as String?,
        taskId: json['taskId'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'id': id,

    'uidShows': uidShows,
    'type': type.name,
    'createdAt': createdAt.toIso8601String(),
    'data': data.toJson(),
    'orgId': orgId,
    'projectId': projectId,
    'taskId': taskId,
  };

  // ---------- Map (Sembast) ----------
  factory NotificationsModel.fromMap(Map<String, dynamic> map) =>
      NotificationsModel.fromJson(map);

  Map<String, dynamic> toMap() => toJson();

  // ---------- Firestore ----------
  factory NotificationsModel.fromFirestore(DocumentSnapshot doc) =>
      NotificationsModel.fromJson(
        doc.data()! as Map<String, dynamic>,
      ).copyWith(id: doc.id);

  // ---------- Copy ----------
  NotificationsModel copyWith({
    String? id,
    String? title,
    List<String>? uidShows,
    NotificationType? type,
    DateTime? createdAt,
    NotificationData? data,
    String? orgId,
    String? projectId,
    String? taskId,
  }) => NotificationsModel(
    id: id ?? this.id,

    uidShows: uidShows ?? this.uidShows,
    type: type ?? this.type,
    createdAt: createdAt ?? this.createdAt,
    data: data ?? this.data,
    orgId: orgId ?? this.orgId,
    projectId: projectId ?? this.projectId,
    taskId: taskId ?? this.taskId,
  );
}
// file: lib/models/notification_data.dart

/// Model untuk menyimpan data dinamis yang digunakan dalam pesan notifikasi.
// lib/models/notification_data.dart

/// Model untuk menyimpan data dinamis yang digunakan dalam pesan notifikasi.
class NotificationData {
  final String? userName;
  final String? orgName;
  final String? projectName;
  final String? taskName;
  final String? description;

  const NotificationData({
    this.userName,
    this.orgName,
    this.projectName,
    this.taskName,
    this.description,
  });

  // ---------- JSON ----------
  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        userName: json['userName'] as String?,
        orgName: json['orgName'] as String?,
        projectName: json['projectName'] as String?,
        taskName: json['taskName'] as String?,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'orgName': orgName,
    'projectName': projectName,
    'taskName': taskName,
    'description': description,
  };

  // ---------- Map (Sembast) ----------
  factory NotificationData.fromMap(Map<String, dynamic> map) =>
      NotificationData.fromJson(map);

  Map<String, dynamic> toMap() => toJson();

  // ---------- Copy ----------
  NotificationData copyWith({
    String? userName,
    String? orgName,
    String? projectName,
    String? taskName,
    String? description,
  }) => NotificationData(
    userName: userName ?? this.userName,
    orgName: orgName ?? this.orgName,
    projectName: projectName ?? this.projectName,
    taskName: taskName ?? this.taskName,
    description: description ?? this.description,
  );
}
