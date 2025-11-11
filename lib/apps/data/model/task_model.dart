import 'package:cloud_firestore/cloud_firestore.dart';

enum Priority { low, medium, high }

enum TaskStatus { all, todo, progress, done }

class TaskModel {
  final String id;
  final String projectId;
  final String orgId;
  final String name;
  final String? description;
  final Priority priority;
  final TaskStatus status;
  final DateTime deadline;
  final DateTime createdAt;
  final String createdBy;
  final List<TaskAssignModel> assigns;

  const TaskModel({
    required this.id,
    required this.projectId,
    required this.orgId,
    required this.name,
    this.description,
    required this.priority,
    required this.status,
    required this.deadline,
    required this.createdAt,
    required this.createdBy,
    required this.assigns,
  });

  factory TaskModel.initial() => TaskModel(
    id: '',
    projectId: '',
    orgId: '',
    name: '',
    description: null,
    priority: Priority.medium,
    status: TaskStatus.todo,
    deadline: DateTime.now().add(const Duration(days: 7)),
    createdAt: DateTime.now(),
    createdBy: '',
    assigns: const [],
  );

  factory TaskModel.fromFirestore(DocumentSnapshot doc) =>
      TaskModel.fromJson(doc.data()! as Map<String, dynamic>);

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    id: json['id'] as String,
    projectId: json['projectId'] as String,
    orgId: json['orgId'] as String,
    name: json['name'] as String,
    description: json['description'] as String?,
    priority: Priority.values.firstWhere((e) => e.name == json['priority']),
    status: TaskStatus.values.firstWhere((e) => e.name == json['status']),
    deadline: _dtFromJson(json['deadline']),
    createdAt: _dtFromJson(json['createdAt']),
    createdBy: json['createdBy'] as String,
    assigns: (json['assigns'] as List<dynamic>)
        .map((e) => TaskAssignModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'projectId': projectId,
    'orgId': orgId,
    'name': name,
    'description': description,
    'priority': priority.name,
    'status': status.name,
    'deadline': _dtToJson(deadline),
    'createdAt': _dtToJson(createdAt),
    'createdBy': createdBy,
    'assigns': assigns.map((e) => e.toJson()).toList(),
  };

  factory TaskModel.fromMap(Map<String, dynamic> map) => TaskModel(
    id: map['id'] as String,
    projectId: map['projectId'] as String,
    orgId: map['orgId'] as String,
    name: map['name'] as String,
    description: map['description'] as String?,
    priority: Priority.values.firstWhere((e) => e.name == map['priority']),
    status: TaskStatus.values.firstWhere((e) => e.name == map['status']),
    deadline: DateTime.fromMillisecondsSinceEpoch(map['deadline'] as int),
    createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    createdBy: map['createdBy'] as String,
    assigns: (map['assigns'] as List<dynamic>)
        .map((e) => TaskAssignModel.fromMap(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'projectId': projectId,
    'orgId': orgId,
    'name': name,
    'description': description,
    'priority': priority.name,
    'status': status.name,
    'deadline': deadline.millisecondsSinceEpoch,
    'createdAt': createdAt.millisecondsSinceEpoch,
    'createdBy': createdBy,
    'assigns': assigns.map((e) => e.toMap()).toList(),
  };

  static int _dtToJson(DateTime dt) => dt.millisecondsSinceEpoch;
  static DateTime _dtFromJson(dynamic json) => json is int
      ? DateTime.fromMillisecondsSinceEpoch(json)
      : (json as Timestamp).toDate();

  TaskModel copyWith({
    String? id,
    String? projectId,
    String? orgId,
    String? name,
    String? description,
    Priority? priority,
    TaskStatus? status,
    DateTime? deadline,
    DateTime? createdAt,
    String? createdBy,
    List<TaskAssignModel>? assigns,
  }) => TaskModel(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    orgId: orgId ?? this.orgId,
    name: name ?? this.name,
    description: description ?? this.description,
    priority: priority ?? this.priority,
    status: status ?? this.status,
    deadline: deadline ?? this.deadline,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy ?? this.createdBy,
    assigns: assigns ?? this.assigns,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          projectId == other.projectId &&
          orgId == other.orgId &&
          name == other.name &&
          description == other.description &&
          priority == other.priority &&
          status == other.status &&
          deadline == other.deadline &&
          createdAt == other.createdAt &&
          createdBy == other.createdBy &&
          assigns == other.assigns;

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    orgId,
    name,
    description,
    priority,
    status,
    deadline,
    createdAt,
    createdBy,
    assigns,
  );

  @override
  String toString() =>
      'TaskModel(id: $id, name: $name, status: ${status.name})';
}

class TaskAssignModel {
  final String id;
  final String uid;
  final String imageUrl;
  final String name;
  final String? projectId;
  final String taskId;

  const TaskAssignModel({
    required this.id,
    required this.uid,
    required this.imageUrl,
    required this.name,
    this.projectId,
    required this.taskId,
  });

  factory TaskAssignModel.initial() => const TaskAssignModel(
    id: '',
    uid: '',
    imageUrl: '',
    name: '',
    projectId: null,
    taskId: '',
  );

  factory TaskAssignModel.fromFirestore(DocumentSnapshot doc) =>
      TaskAssignModel.fromJson(doc.data()! as Map<String, dynamic>);

  factory TaskAssignModel.fromJson(Map<String, dynamic> json) =>
      TaskAssignModel(
        id: json['id'] as String,
        uid: json['uid'] as String,
        imageUrl: json['imageUrl'] as String,
        name: json['name'] as String,
        projectId: json['projectId'] as String?,
        taskId: json['taskId'] as String,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'uid': uid,
    'imageUrl': imageUrl,
    'name': name,
    'projectId': projectId,
    'taskId': taskId,
  };

  factory TaskAssignModel.fromMap(Map<String, dynamic> map) => TaskAssignModel(
    id: map['id'] as String,
    uid: map['uid'] as String,
    imageUrl: map['imageUrl'] as String,
    name: map['name'] as String,
    projectId: map['projectId'] as String?,
    taskId: map['taskId'] as String,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'uid': uid,
    'imageUrl': imageUrl,
    'name': name,
    'projectId': projectId,
    'taskId': taskId,
  };

  TaskAssignModel copyWith({
    String? id,
    String? uid,
    String? imageUrl,
    String? name,
    String? projectId,
    String? taskId,
  }) => TaskAssignModel(
    id: id ?? this.id,
    uid: uid ?? this.uid,
    imageUrl: imageUrl ?? this.imageUrl,
    name: name ?? this.name,
    projectId: projectId ?? this.projectId,
    taskId: taskId ?? this.taskId,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAssignModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          uid == other.uid &&
          imageUrl == other.imageUrl &&
          name == other.name &&
          projectId == other.projectId &&
          taskId == other.taskId;

  @override
  int get hashCode => Object.hash(id, uid, imageUrl, name, projectId, taskId);

  @override
  String toString() =>
      'TaskAssignModel(id: $id, uid: $uid, name: $name, taskId: $taskId)';
}
