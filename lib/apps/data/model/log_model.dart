import 'package:cloud_firestore/cloud_firestore.dart';

class LogModel {
  final String id;
  final String uid;
  final String orgId;
  final String? projectId;
  final String? taskId;
  final DateTime createdAt;
  final String? event;

  const LogModel({
    required this.id,
    required this.uid,
    required this.orgId,
    this.projectId,
    this.taskId,
    required this.createdAt,
    this.event,
  });

  /* -------------------------------------------------
   * Firebase (Firestore) helpers
   * ------------------------------------------------- */
  factory LogModel.fromFirestore(DocumentSnapshot doc) =>
      LogModel.fromJson(doc.data()! as Map<String, dynamic>);

  factory LogModel.fromJson(Map<String, dynamic> json) => LogModel(
    id: json['id'] as String,
    uid: json['uid'] as String,
    orgId: json['orgId'] as String,
    projectId: json['projectId'] as String?,
    taskId: json['taskId'] as String?,
    createdAt: _dateTimeFromJson(json['createdAt']),
    event: json['event'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'uid': uid,
    'orgId': orgId,
    'projectId': projectId,
    'taskId': taskId,
    'createdAt': _dateTimeToJson(createdAt),
    'event': event,
  };

  /* -------------------------------------------------
   * Sembast helpers (Map<String,dynamic> dengan int)
   * ------------------------------------------------- */
  factory LogModel.fromMap(Map<String, dynamic> map) => LogModel(
    id: map['id'] as String,
    uid: map['uid'] as String,
    orgId: map['orgId'] as String,
    projectId: map['projectId'] as String?,
    taskId: map['taskId'] as String?,
    createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    event: map['event'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'uid': uid,
    'orgId': orgId,
    'projectId': projectId,
    'taskId': taskId,
    'createdAt': createdAt.millisecondsSinceEpoch,
    'event': event,
  };

  /* -------------------------------------------------
   * Util: konversi DateTime <-> int (epoch-milis)
   * ------------------------------------------------- */
  static int _dateTimeToJson(DateTime dt) => dt.millisecondsSinceEpoch;
  static DateTime _dateTimeFromJson(dynamic json) => json is int
      ? DateTime.fromMillisecondsSinceEpoch(json)
      : (json as Timestamp).toDate();

  /* -------------------------------------------------
   * copyWith
   * ------------------------------------------------- */
  LogModel copyWith({
    String? id,
    String? uid,
    String? orgId,
    String? projectId,
    String? taskId,
    DateTime? createdAt,
    String? event,
  }) => LogModel(
    id: id ?? this.id,
    uid: uid ?? this.uid,
    orgId: orgId ?? this.orgId,
    projectId: projectId ?? this.projectId,
    taskId: taskId ?? this.taskId,
    createdAt: createdAt ?? this.createdAt,
    event: event ?? this.event,
  );

  /* -------------------------------------------------
   * Equality & hash
   * ------------------------------------------------- */
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          uid == other.uid &&
          orgId == other.orgId &&
          projectId == other.projectId &&
          taskId == other.taskId &&
          createdAt == other.createdAt &&
          event == other.event;

  @override
  int get hashCode =>
      Object.hash(id, uid, orgId, projectId, taskId, createdAt, event);

  /* -------------------------------------------------
   * toString
   * ------------------------------------------------- */
  @override
  String toString() =>
      'LogModel(id: $id, uid: $uid, orgId: $orgId, event: $event)';
}
