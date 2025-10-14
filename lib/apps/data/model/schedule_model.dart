import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleModel {
  final String id;
  final String uid;
  final String type;
  final String? orgId;
  final DateTime start;
  final DateTime end;
  final DateTime creatdAt;
  final String title;
  final String? description;

  const ScheduleModel({
    required this.id,
    required this.uid,
    required this.type,
    this.orgId,
    required this.start,
    required this.end,
    required this.creatdAt,
    required this.title,
    this.description,
  });

  factory ScheduleModel.fromFirestore(DocumentSnapshot doc) =>
      ScheduleModel.fromJson(doc.data()! as Map<String, dynamic>);

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
    id: json['id'] as String,
    uid: json['uid'] as String,
    type: json['type'] as String,
    orgId: json['orgId'] as String?,
    start: _dtFromJson(json['start']),
    end: _dtFromJson(json['end']),
    creatdAt: _dtFromJson(json['creatdAt']),
    title: json['title'] as String,
    description: json['description'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'uid': uid,
    'type': type,
    'orgId': orgId,
    'start': _dtToJson(start),
    'end': _dtToJson(end),
    'creatdAt': _dtToJson(creatdAt),
    'title': title,
    'description': description,
  };

  factory ScheduleModel.fromMap(Map<String, dynamic> map) => ScheduleModel(
    id: map['id'] as String,
    uid: map['uid'] as String,
    type: map['type'] as String,
    orgId: map['orgId'] as String?,
    start: DateTime.fromMillisecondsSinceEpoch(map['start'] as int),
    end: DateTime.fromMillisecondsSinceEpoch(map['end'] as int),
    creatdAt: DateTime.fromMillisecondsSinceEpoch(map['creatdAt'] as int),
    title: map['title'] as String,
    description: map['description'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'uid': uid,
    'type': type,
    'orgId': orgId,
    'start': start.millisecondsSinceEpoch,
    'end': end.millisecondsSinceEpoch,
    'creatdAt': creatdAt.millisecondsSinceEpoch,
    'title': title,
    'description': description,
  };

  static int _dtToJson(DateTime dt) => dt.millisecondsSinceEpoch;
  static DateTime _dtFromJson(dynamic json) => json is int
      ? DateTime.fromMillisecondsSinceEpoch(json)
      : (json as Timestamp).toDate();

  ScheduleModel copyWith({
    String? id,
    String? uid,
    String? type,
    String? orgId,
    DateTime? start,
    DateTime? end,
    DateTime? creatdAt,
    String? title,
    String? description,
  }) => ScheduleModel(
    id: id ?? this.id,
    uid: uid ?? this.uid,
    type: type ?? this.type,
    orgId: orgId ?? this.orgId,
    start: start ?? this.start,
    end: end ?? this.end,
    creatdAt: creatdAt ?? this.creatdAt,
    title: title ?? this.title,
    description: description ?? this.description,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          uid == other.uid &&
          type == other.type &&
          orgId == other.orgId &&
          start == other.start &&
          end == other.end &&
          creatdAt == other.creatdAt &&
          title == other.title &&
          description == other.description;

  @override
  int get hashCode => Object.hash(
    id,
    uid,
    type,
    orgId,
    start,
    end,
    creatdAt,
    title,
    description,
  );

  @override
  String toString() =>
      'ScheduleModel(id: $id, uid: $uid, type: $type, title: $title)';
}
