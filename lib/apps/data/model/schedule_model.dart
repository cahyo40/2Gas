// schedule_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

enum ScheduleType { all, deadline, event }

enum ScheduleAccess { org, private }

extension ScheduleTypeX on ScheduleType {
  String get name => toString().split('.').last;
  static ScheduleType fromName(String s) =>
      ScheduleType.values.firstWhere((e) => e.name == s);
}

extension ScheduleAccessX on ScheduleAccess {
  String get name => toString().split('.').last;
  static ScheduleAccess fromName(String s) =>
      ScheduleAccess.values.firstWhere((e) => e.name == s);
}

class ScheduleModel {
  final String id;
  final String uid;
  final ScheduleType type;
  final ScheduleAccess access;
  final List<String> uidAccess;
  final String? orgId;
  final String? projectId;
  final String? taskId;
  final DateTime date;
  final DateTime createdAt;
  final String title;
  final String? description;

  const ScheduleModel({
    required this.id,
    required this.uid,
    required this.type,
    required this.access,
    required this.uidAccess,
    this.orgId,
    this.projectId,
    this.taskId,
    required this.date,
    required this.createdAt,
    required this.title,
    this.description,
  });

  // ------------------ JSON ------------------
  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
    id: json['id'] as String,
    uid: json['uid'] as String,
    type: ScheduleTypeX.fromName(json['type'] as String),
    access: ScheduleAccessX.fromName(json['access'] as String),
    uidAccess: List<String>.from(json['uidAccess'] as List),
    orgId: json['orgId'] as String?,
    projectId: json['projectId'] as String?,
    taskId: json['taskId'] as String?,
    date: DateTime.parse(json['date'] as String),
    createdAt: DateTime.parse(json['createdAt'] as String),
    title: json['title'] as String,
    description: json['description'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'uid': uid,
    'type': type.name,
    'access': access.name,
    'uidAccess': uidAccess,
    'orgId': orgId,
    'projectId': projectId,
    'taskId': taskId,
    'date': date.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
    'title': title,
    'description': description,
  };

  // ------------------ Sembast / Map ------------------
  factory ScheduleModel.fromMap(Map<String, dynamic> map) =>
      ScheduleModel.fromJson(map);

  Map<String, dynamic> toMap() => toJson();

  // ------------------ Firestore ------------------
  factory ScheduleModel.fromFirestore(DocumentSnapshot doc) =>
      ScheduleModel.fromJson(
        doc.data()! as Map<String, dynamic>,
      ).copyWith(id: doc.id);

  Map<String, dynamic> toFirestore() => toJson()..remove('id');

  // ------------------ Copy ------------------
  ScheduleModel copyWith({
    String? id,
    String? uid,
    ScheduleType? type,
    ScheduleAccess? access,
    List<String>? uidAccess,
    String? orgId,
    String? projectId,
    String? taskId,
    DateTime? date,
    DateTime? createdAt,
    String? title,
    String? description,
  }) => ScheduleModel(
    id: id ?? this.id,
    uid: uid ?? this.uid,
    type: type ?? this.type,
    access: access ?? this.access,
    uidAccess: uidAccess ?? this.uidAccess,
    orgId: orgId ?? this.orgId,
    projectId: projectId ?? this.projectId,
    taskId: taskId ?? this.taskId,
    date: date ?? this.date,
    createdAt: createdAt ?? this.createdAt,
    title: title ?? this.title,
    description: description ?? this.description,
  );
}
