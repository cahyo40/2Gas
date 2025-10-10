import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectModel {
  final String id;
  final String name;
  final String orgId;
  final String priority;
  final String? description;
  final DateTime deadline;
  final DateTime createdAt;
  final String createdBy;
  final List<ProjectAssignModel> assign;

  const ProjectModel({
    required this.id,
    required this.name,
    required this.orgId,
    required this.priority,
    this.description,
    required this.deadline,
    required this.createdAt,
    required this.assign,
    required this.createdBy,
  });

  factory ProjectModel.fromFirestore(DocumentSnapshot doc) =>
      ProjectModel.fromJson(doc.data()! as Map<String, dynamic>);

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
    id: json['id'] as String,
    name: json['name'] as String,
    orgId: json['orgId'] as String,
    priority: json['priority'] as String,
    description: json['description'] as String?,
    deadline: _dtFromJson(json['deadline']),
    createdAt: _dtFromJson(json['createdAt']),
    createdBy: json['createdBy'] as String,
    assign: (json['assign'] as List<dynamic>)
        .map((e) => ProjectAssignModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'orgId': orgId,
    'priority': priority,
    'description': description,
    'deadline': _dtToJson(deadline),
    'createdAt': _dtToJson(createdAt),
    'createdBy': createdBy,
    'assign': assign.map((e) => e.toJson()).toList(),
  };

  factory ProjectModel.fromMap(Map<String, dynamic> map) => ProjectModel(
    id: map['id'] as String,
    name: map['name'] as String,
    orgId: map['orgId'] as String,
    priority: map['priority'] as String,
    createdBy: map['createdBy'] as String,
    description: map['description'] as String?,
    deadline: DateTime.fromMillisecondsSinceEpoch(map['deadline'] as int),
    createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    assign: (map['assign'] as List<dynamic>)
        .map((e) => ProjectAssignModel.fromMap(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'orgId': orgId,
    'priority': priority,
    'description': description,
    'createdBy': createdBy,
    'deadline': deadline.millisecondsSinceEpoch,
    'createdAt': createdAt.millisecondsSinceEpoch,
    'assign': assign.map((e) => e.toMap()).toList(),
  };

  static int _dtToJson(DateTime dt) => dt.millisecondsSinceEpoch;
  static DateTime _dtFromJson(dynamic json) => json is int
      ? DateTime.fromMillisecondsSinceEpoch(json)
      : (json as Timestamp).toDate();

  ProjectModel copyWith({
    String? id,
    String? name,
    String? orgId,
    String? priority,
    String? description,
    DateTime? deadline,
    DateTime? createdAt,
    String? createdBy,
    List<ProjectAssignModel>? assign,
  }) => ProjectModel(
    createdBy: createdBy ?? this.createdBy,
    id: id ?? this.id,
    name: name ?? this.name,
    orgId: orgId ?? this.orgId,
    priority: priority ?? this.priority,
    description: description ?? this.description,
    deadline: deadline ?? this.deadline,
    createdAt: createdAt ?? this.createdAt,
    assign: assign ?? this.assign,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          createdBy == other.createdBy &&
          orgId == other.orgId &&
          priority == other.priority &&
          description == other.description &&
          deadline == other.deadline &&
          createdAt == other.createdAt &&
          assign == other.assign;

  @override
  int get hashCode => Object.hash(
    id,
    name,
    orgId,
    priority,
    description,
    deadline,
    createdAt,
    assign,
    createdBy,
  );

  @override
  String toString() => 'ProjectModel(id: $id, name: $name, orgId: $orgId)';
}

class ProjectAssignModel {
  final String id;
  final String projectId;
  final String uid;

  const ProjectAssignModel({
    required this.id,
    required this.projectId,
    required this.uid,
  });

  factory ProjectAssignModel.fromFirestore(DocumentSnapshot doc) =>
      ProjectAssignModel.fromJson(doc.data()! as Map<String, dynamic>);

  factory ProjectAssignModel.fromJson(Map<String, dynamic> json) =>
      ProjectAssignModel(
        id: json['id'] as String,
        projectId: json['projectId'] as String,
        uid: json['uid'] as String,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'projectId': projectId,
    'uid': uid,
  };

  factory ProjectAssignModel.fromMap(Map<String, dynamic> map) =>
      ProjectAssignModel(
        id: map['id'] as String,
        projectId: map['projectId'] as String,
        uid: map['uid'] as String,
      );

  Map<String, dynamic> toMap() => {
    'id': id,
    'projectId': projectId,
    'uid': uid,
  };

  ProjectAssignModel copyWith({String? id, String? projectId, String? uid}) =>
      ProjectAssignModel(
        id: id ?? this.id,
        projectId: projectId ?? this.projectId,
        uid: uid ?? this.uid,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectAssignModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          projectId == other.projectId &&
          uid == other.uid;

  @override
  int get hashCode => Object.hash(id, projectId, uid);

  @override
  String toString() =>
      'ProjectAssignModel(id: $id, projectId: $projectId, uid: $uid)';
}
