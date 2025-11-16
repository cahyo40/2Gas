import 'package:cloud_firestore/cloud_firestore.dart';

enum ActivityType {
  taskCreated,
  taskUpdated,
  taskDeleted,
  taskMoved,
  projectCreated,
  projectUpdated,
  projectDeleted,
  projectCompleted,
  projectComment,
  memberJoin,
  memberRemoved,
  memberLeft,
  memberChangeRole,
  scheduleCreated,
  scheduleEdited,
  scheduleCanceled,
  organizationCreated,
  organizationUpdated,
}

enum ActivityTypeCategory {
  all,
  task,
  project,
  member,
  organization,
  comment,
  attachment,
  label,
}

extension ActivityCategory on ActivityType {
  String get category {
    if (name.startsWith('task')) return 'Task';
    if (name.startsWith('project')) return 'Project';
    if (name.startsWith('member')) return 'Member';

    if (name.startsWith('schedule')) return 'Schedule';
    if (name.startsWith('organization')) return 'Organization';

    return 'Other';
  }
}

class ActivityModel {
  final String id;
  final String orgId;
  final String? projectId;
  final String? taskId;
  final String? createdBy;

  final ActivityType type;
  final DateTime createdAt;
  final ActivityMeta? meta;

  const ActivityModel({
    required this.id,
    required this.orgId,
    this.projectId,
    this.taskId,
    this.createdBy,

    required this.type,
    required this.createdAt,
    this.meta,
  });

  factory ActivityModel.initial() => ActivityModel(
    id: '',
    orgId: '',

    type: ActivityType.memberJoin,
    createdAt: DateTime.now(),
  );

  factory ActivityModel.fromFirestore(DocumentSnapshot doc) =>
      ActivityModel.fromJson(doc.data()! as Map<String, dynamic>);

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
    id: json['id'] as String,
    orgId: json['orgId'] as String,
    projectId: json['projectId'] as String?,
    taskId: json['taskId'] as String?,
    createdBy: json['createdBy'] as String?,

    type: ActivityType.values.firstWhere((e) => e.name == json['type']),
    createdAt: _dtFromJson(json['createdAt']),
    meta: json['meta'] != null
        ? ActivityMeta.fromMap(json['meta'] as Map<String, dynamic>)
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'orgId': orgId,
    'projectId': projectId,
    'taskId': taskId,
    'createdBy': createdBy,

    'type': type.name,
    'createdAt': _dtToJson(createdAt),
    'meta': meta?.toMap(),
  };

  factory ActivityModel.fromMap(Map<String, dynamic> map) => ActivityModel(
    id: map['id'] as String,
    orgId: map['orgId'] as String,
    projectId: map['projectId'] as String?,
    taskId: map['taskId'] as String?,
    createdBy: map['createdBy'] as String?,

    type: ActivityType.values.firstWhere((e) => e.name == map['type']),
    createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    meta: map['meta'] != null
        ? ActivityMeta.fromMap(map['meta'] as Map<String, dynamic>)
        : null,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'orgId': orgId,
    'projectId': projectId,
    'taskId': taskId,
    'createdBy': createdBy,

    'type': type.name,
    'createdAt': createdAt.millisecondsSinceEpoch,
    'meta': meta?.toMap(),
  };

  static int _dtToJson(DateTime dt) => dt.millisecondsSinceEpoch;
  static DateTime _dtFromJson(dynamic json) => json is int
      ? DateTime.fromMillisecondsSinceEpoch(json)
      : (json as Timestamp).toDate();

  ActivityModel copyWith({
    String? id,
    String? orgId,
    String? projectId,
    String? taskId,
    String? createdBy,
    String? title,
    String? description,
    ActivityType? type,
    DateTime? createdAt,
    ActivityMeta? meta,
  }) => ActivityModel(
    id: id ?? this.id,
    orgId: orgId ?? this.orgId,
    projectId: projectId ?? this.projectId,
    taskId: taskId ?? this.taskId,
    createdBy: createdBy ?? this.createdBy,

    type: type ?? this.type,
    createdAt: createdAt ?? this.createdAt,
    meta: meta ?? this.meta,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          orgId == other.orgId &&
          projectId == other.projectId &&
          taskId == other.taskId &&
          createdBy == other.createdBy &&
          type == other.type &&
          createdAt == other.createdAt &&
          meta == other.meta;

  @override
  int get hashCode => Object.hash(
    id,
    orgId,
    projectId,
    taskId,
    createdBy,

    type,
    createdAt,
    meta,
  );

  @override
  String toString() =>
      'ActivityModel(id: $id, orgId: $orgId, type: ${type.name})';
}

class ActivityMeta {
  final String? user;
  final String? taskName;
  final String? projectName;
  final String? orgName;
  final String? info;
  final String? scheduleName;

  const ActivityMeta({
    this.user,
    this.taskName,
    this.projectName,
    this.orgName,
    this.info,
    this.scheduleName,
  });

  factory ActivityMeta.initial() => const ActivityMeta(
    user: null,
    taskName: null,
    projectName: null,
    orgName: null,
    info: null,
    scheduleName: null,
  );

  factory ActivityMeta.fromFirestore(DocumentSnapshot doc) =>
      ActivityMeta.fromJson(doc.data()! as Map<String, dynamic>);

  factory ActivityMeta.fromJson(Map<String, dynamic> json) => ActivityMeta(
    user: json['user'] as String?,
    taskName: json['taskName'] as String?,
    projectName: json['projectName'] as String?,
    orgName: json['orgName'] as String?,
    info: json['info'] as String?,
    scheduleName: json['scheduleName'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'user': user,
    'taskName': taskName,
    'projectName': projectName,
    'orgName': orgName,
    'info': info,
    'scheduleName': scheduleName,
  };

  factory ActivityMeta.fromMap(Map<String, dynamic> map) => ActivityMeta(
    user: map['user'] as String?,
    taskName: map['taskName'] as String?,
    projectName: map['projectName'] as String?,
    orgName: map['orgName'] as String?,
    info: map['info'] as String?,
    scheduleName: map['scheduleName'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'user': user,
    'taskName': taskName,
    'projectName': projectName,
    'orgName': orgName,
    'info': info,
    'scheduleName': scheduleName,
  };

  ActivityMeta copyWith({
    String? user,
    String? taskName,
    String? projectName,
    String? orgName,
    String? info,
    String? scheduleName,
  }) => ActivityMeta(
    user: user ?? this.user,
    taskName: taskName ?? this.taskName,
    projectName: projectName ?? this.projectName,
    orgName: orgName ?? this.orgName,
    info: info ?? this.info,
    scheduleName: scheduleName ?? this.scheduleName,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityMeta &&
          runtimeType == other.runtimeType &&
          user == other.user &&
          taskName == other.taskName &&
          projectName == other.projectName &&
          orgName == other.orgName &&
          info == other.info &&
          scheduleName == other.scheduleName;

  @override
  int get hashCode =>
      Object.hash(user, taskName, projectName, orgName, info, scheduleName);

  @override
  String toString() =>
      'ActivityMeta(user: $user, taskName: $taskName, projectName: $projectName, orgName: $orgName, info: $info, scheduleName: $scheduleName)';
}
