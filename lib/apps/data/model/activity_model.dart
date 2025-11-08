import 'package:cloud_firestore/cloud_firestore.dart';

enum ActivityType {
  taskCreated,
  taskUpdated,
  taskDeleted,
  taskCompleted,
  taskReopened,
  taskAssigned,
  taskUnassigned,
  taskMoved,
  taskCommented,
  taskAttachmentAdded,
  taskAttachmentRemoved,
  taskLabelAdded,
  taskLabelRemoved,
  projectCreated,
  projectUpdated,
  projectDeleted,
  projectArchived,
  projectRestored,
  memberInvited,
  memberJoined,
  memberRemoved,
  memberRoleUpdated,
  organizationCreated,
  organizationUpdated,
  organizationDeleted,
  organizationJoined,
  organizationLeft,
  commentAdded,
  commentEdited,
  commentDeleted,
  attachmentAdded,
  attachmentRemoved,
  labelCreated,
  labelUpdated,
  labelDeleted,
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
    if (name.startsWith('organization')) return 'Organization';
    if (name.startsWith('comment')) return 'Comment';
    if (name.startsWith('attachment')) return 'Attachment';
    if (name.startsWith('label')) return 'Label';
    return 'Other';
  }
}

class ActivityModel {
  final String id;
  final String orgId;
  final String? projectId;
  final String? taskId;
  final String? createdBy;
  final String title;
  final String description;
  final ActivityType type;
  final DateTime createdAt;
  final ActivityMeta? meta;

  const ActivityModel({
    required this.id,
    required this.orgId,
    this.projectId,
    this.taskId,
    this.createdBy,
    required this.title,
    required this.description,
    required this.type,
    required this.createdAt,
    this.meta,
  });

  factory ActivityModel.initial() => ActivityModel(
    id: '',
    orgId: '',
    title: '',
    description: '',
    type: ActivityType.organizationCreated,
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
    title: json['title'] as String,
    description: json['description'] as String,
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
    'title': title,
    'description': description,
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
    title: map['title'] as String,
    description: map['description'] as String,
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
    'title': title,
    'description': description,
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
    title: title ?? this.title,
    description: description ?? this.description,
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
          title == other.title &&
          description == other.description &&
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
    title,
    description,
    type,
    createdAt,
    meta,
  );

  @override
  String toString() =>
      'ActivityModel(id: $id, orgId: $orgId, type: ${type.name})';
}

class ActivityMeta {
  final String? taskName;
  final String? projectName;
  final String? organizationName;
  final String? memberName;
  final String? commentPreview;
  final String? labelName;
  final String? attachmentName;

  const ActivityMeta({
    this.taskName,
    this.projectName,
    this.organizationName,
    this.memberName,
    this.commentPreview,
    this.labelName,
    this.attachmentName,
  });

  factory ActivityMeta.fromMap(Map<String, dynamic> map) => ActivityMeta(
    taskName: map['taskName'] as String?,
    projectName: map['projectName'] as String?,
    organizationName: map['organizationName'] as String?,
    memberName: map['memberName'] as String?,
    commentPreview: map['commentPreview'] as String?,
    labelName: map['labelName'] as String?,
    attachmentName: map['attachmentName'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'taskName': taskName,
    'projectName': projectName,
    'organizationName': organizationName,
    'memberName': memberName,
    'commentPreview': commentPreview,
    'labelName': labelName,
    'attachmentName': attachmentName,
  };

  ActivityMeta copyWith({
    String? taskName,
    String? projectName,
    String? organizationName,
    String? memberName,
    String? commentPreview,
    String? labelName,
    String? attachmentName,
  }) => ActivityMeta(
    taskName: taskName ?? this.taskName,
    projectName: projectName ?? this.projectName,
    organizationName: organizationName ?? this.organizationName,
    memberName: memberName ?? this.memberName,
    commentPreview: commentPreview ?? this.commentPreview,
    labelName: labelName ?? this.labelName,
    attachmentName: attachmentName ?? this.attachmentName,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityMeta &&
          runtimeType == other.runtimeType &&
          taskName == other.taskName &&
          projectName == other.projectName &&
          organizationName == other.organizationName &&
          memberName == other.memberName &&
          commentPreview == other.commentPreview &&
          labelName == other.labelName &&
          attachmentName == other.attachmentName;

  @override
  int get hashCode => Object.hash(
    taskName,
    projectName,
    organizationName,
    memberName,
    commentPreview,
    labelName,
    attachmentName,
  );

  @override
  String toString() =>
      'ActivityMeta(taskName: $taskName, projectName: $projectName, organizationName: $organizationName)';
}
