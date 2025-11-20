import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twogass/apps/data/model/project_category_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';

enum ProjectStatus { active, completed, overdue }

class ProjectModel {
  final String id;
  final String name;
  final String orgId;
  final Priority priority;
  final ProjectStatus status;
  final String? description;
  final DateTime deadline;
  final DateTime createdAt;
  final String createdBy;
  final List<ProjectCategoryModel> categories;
  final List<ProjectAssignModel> assign;

  const ProjectModel({
    required this.id,
    required this.name,
    required this.orgId,
    required this.priority,
    required this.status,
    this.description,
    required this.deadline,
    required this.createdAt,
    required this.createdBy,
    required this.categories,
    required this.assign,
  });

  factory ProjectModel.initial() => ProjectModel(
    id: '',
    name: '',
    orgId: '',
    priority: Priority.medium,
    status: ProjectStatus.active,
    description: null,
    deadline: DateTime.now().add(const Duration(days: 30)),
    createdAt: DateTime.now(),
    createdBy: '',
    categories: const [],
    assign: const [],
  );

  // 1. fromFirestore / fromJson → tetap pakai versi lama (dengan categories & assign)
  factory ProjectModel.fromFirestore(DocumentSnapshot doc) =>
      ProjectModel.fromFirebase(doc.data()! as Map<String, dynamic>);

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
    id: json['id'] as String,
    name: json['name'] as String,
    orgId: json['orgId'] as String,
    priority: Priority.values.firstWhere((e) => e.name == json['priority']),
    status: ProjectStatus.values.firstWhere((e) => e.name == json['status']),
    description: json['description'] as String?,
    deadline: _dtFromJson(json['deadline']),
    createdAt: _dtFromJson(json['createdAt']),
    createdBy: json['createdBy'] as String,
    categories:
        (json['categories'] as List<dynamic>?)
            ?.map(
              (e) => ProjectCategoryModel.fromJson(e as Map<String, dynamic>),
            )
            .toList() ??
        const [],
    assign:
        (json['assign'] as List<dynamic>?)
            ?.map((e) => ProjectAssignModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        const [],
  );

  // 2. fromFirebase → khusus baca dokumen Firestore yang tidak punya categories & assign
  factory ProjectModel.fromFirebase(Map<String, dynamic> json) => ProjectModel(
    id: json['id'] as String,
    name: json['name'] as String,
    orgId: json['orgId'] as String,
    priority: Priority.values.firstWhere((e) => e.name == json['priority']),
    status: ProjectStatus.values.firstWhere((e) => e.name == json['status']),
    description: json['description'] as String?,
    deadline: _dtFromJson(json['deadline']),
    createdAt: _dtFromJson(json['createdAt']),
    createdBy: json['createdBy'] as String,
    categories:
        (json['categories'] as List<dynamic>?)
            ?.map(
              (e) => ProjectCategoryModel.fromJson(e as Map<String, dynamic>),
            )
            .toList() ??
        const [],
    assign: const [], // selalu kosong
  );

  // 3. toFirebase → kirim tanpa categories & assign
  Map<String, dynamic> toFirebase() => {
    'id': id,
    'name': name,
    'orgId': orgId,
    'priority': priority.name,
    'status': status.name,
    'description': description,
    'deadline': _dtToJson(deadline),
    'createdAt': _dtToJson(createdAt),
    'createdBy': createdBy,
    'categories': categories.map((e) => e.toJson()).toList(),
    // categories & assign tidak disertakan
  };

  // 4. toJson → tetap lengkap (kalau dibutuhkan untuk encode lokal)
  Map<String, dynamic> toJson() => {
    ...toFirebase(),

    'assign': assign.map((e) => e.toJson()).toList(),
  };

  factory ProjectModel.fromMap(Map<String, dynamic> map) => ProjectModel(
    id: map['id'] as String,
    name: map['name'] as String,
    orgId: map['orgId'] as String,
    priority: Priority.values.firstWhere((e) => e.name == map['priority']),
    status: ProjectStatus.values.firstWhere((e) => e.name == map['status']),
    description: map['description'] as String?,
    deadline: DateTime.fromMillisecondsSinceEpoch(map['deadline'] as int),
    createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    createdBy: map['createdBy'] as String,
    categories: (map['categories'] as List<dynamic>)
        .map((e) => ProjectCategoryModel.fromMap(e as Map<String, dynamic>))
        .toList(),
    assign: (map['assign'] as List<dynamic>)
        .map((e) => ProjectAssignModel.fromMap(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'orgId': orgId,
    'priority': priority.name,
    'status': status.name,
    'description': description,
    'deadline': deadline.millisecondsSinceEpoch,
    'createdAt': createdAt.millisecondsSinceEpoch,
    'createdBy': createdBy,
    'categories': categories.map((e) => e.toMap()).toList(),
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
    Priority? priority,
    ProjectStatus? status,
    String? description,
    DateTime? deadline,
    DateTime? createdAt,
    String? createdBy,
    List<ProjectCategoryModel>? categories,
    List<ProjectAssignModel>? assign,
  }) => ProjectModel(
    id: id ?? this.id,
    name: name ?? this.name,
    orgId: orgId ?? this.orgId,
    priority: priority ?? this.priority,
    status: status ?? this.status,
    description: description ?? this.description,
    deadline: deadline ?? this.deadline,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy ?? this.createdBy,
    categories: categories ?? this.categories,
    assign: assign ?? this.assign,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          orgId == other.orgId &&
          priority == other.priority &&
          status == other.status &&
          description == other.description &&
          deadline == other.deadline &&
          createdAt == other.createdAt &&
          createdBy == other.createdBy &&
          categories == other.categories &&
          assign == other.assign;

  @override
  int get hashCode => Object.hash(
    id,
    name,
    orgId,
    priority,
    status,
    description,
    deadline,
    createdAt,
    createdBy,
    categories,
    assign,
  );

  @override
  String toString() =>
      'ProjectModel(id: $id, name: $name, status: ${status.name})';
}

class ProjectAssignModel {
  final String id;
  final String projectId;
  final String orgId;
  final String uid;
  final String imageUrl;
  final String playerId; // <<< NEW REQUIRED FIELD

  const ProjectAssignModel({
    required this.id,
    required this.projectId,
    required this.orgId,
    required this.uid,
    required this.imageUrl,
    required this.playerId, // <<< REQUIRED
  });

  factory ProjectAssignModel.initial() => const ProjectAssignModel(
    id: '',
    projectId: '',
    orgId: '',
    uid: '',
    imageUrl: '',
    playerId: '', // <<< INITIAL EMPTY
  );

  factory ProjectAssignModel.fromJson(Map<String, dynamic> json) =>
      ProjectAssignModel(
        id: json['id'] as String,
        orgId: json['orgId'] as String,
        projectId: json['projectId'] as String,
        uid: json['uid'] as String,
        imageUrl: json['imageUrl'] as String,
        playerId: json['playerId'] as String,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'projectId': projectId,
    'orgId': orgId,
    'uid': uid,
    'imageUrl': imageUrl,
    'playerId': playerId,
  };

  factory ProjectAssignModel.fromFirestore(DocumentSnapshot doc) =>
      ProjectAssignModel.fromJson(doc.data()! as Map<String, dynamic>);

  factory ProjectAssignModel.fromMap(Map<String, dynamic> map) =>
      ProjectAssignModel(
        id: map['id'] as String,
        projectId: map['projectId'] as String,
        orgId: map['orgId'] as String,
        uid: map['uid'] as String,
        imageUrl: map['imageUrl'] as String,
        playerId: map['playerId'] as String,
      );

  Map<String, dynamic> toMap() => {
    'id': id,
    'projectId': projectId,
    'orgId': orgId,
    'uid': uid,
    'imageUrl': imageUrl,
    'playerId': playerId,
  };

  ProjectAssignModel copyWith({
    String? id,
    String? projectId,
    String? orgId,
    String? uid,
    String? imageUrl,
    String? playerId,
  }) => ProjectAssignModel(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    orgId: orgId ?? this.orgId,
    uid: uid ?? this.uid,
    imageUrl: imageUrl ?? this.imageUrl,
    playerId: playerId ?? this.playerId,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectAssignModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          projectId == other.projectId &&
          orgId == other.orgId &&
          imageUrl == other.imageUrl &&
          uid == other.uid &&
          playerId == other.playerId;

  @override
  int get hashCode =>
      Object.hash(id, projectId, orgId, uid, imageUrl, playerId);

  @override
  String toString() =>
      'ProjectAssignModel(id: $id, projectId: $projectId, uid: $uid, playerId: $playerId)';
}
