import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String id;
  final String orgId;
  final String projectId;
  final String createdBy;
  final String comment;
  final DateTime createdAt;

  const CommentModel({
    required this.id,
    required this.orgId,
    required this.projectId,
    required this.createdBy,
    required this.comment,
    required this.createdAt,
  });

  factory CommentModel.initial() => CommentModel(
    id: '',
    orgId: '',
    projectId: '',
    createdBy: '',
    comment: '',
    createdAt: DateTime.now(),
  );

  factory CommentModel.fromFirestore(DocumentSnapshot doc) =>
      CommentModel.fromJson(doc.data()! as Map<String, dynamic>);

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    id: json['id'] as String,
    orgId: json['orgId'] as String,
    projectId: json['projectId'] as String,
    createdBy: json['createdBy'] as String,
    comment: json['comment'] as String,
    createdAt: _dtFromJson(json['createdAt']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'orgId': orgId,
    'projectId': projectId,
    'createdBy': createdBy,
    'comment': comment,
    'createdAt': _dtToJson(createdAt),
  };

  factory CommentModel.fromMap(Map<String, dynamic> map) => CommentModel(
    id: map['id'] as String,
    orgId: map['orgId'] as String,
    projectId: map['projectId'] as String,
    createdBy: map['createdBy'] as String,
    comment: map['comment'] as String,
    createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'orgId': orgId,
    'projectId': projectId,
    'createdBy': createdBy,
    'comment': comment,
    'createdAt': createdAt.millisecondsSinceEpoch,
  };

  static int _dtToJson(DateTime dt) => dt.millisecondsSinceEpoch;
  static DateTime _dtFromJson(dynamic json) => json is int
      ? DateTime.fromMillisecondsSinceEpoch(json)
      : (json as Timestamp).toDate();

  CommentModel copyWith({
    String? id,
    String? orgId,
    String? projectId,
    String? createdBy,
    String? comment,
    DateTime? createdAt,
  }) => CommentModel(
    id: id ?? this.id,
    orgId: orgId ?? this.orgId,
    projectId: projectId ?? this.projectId,
    createdBy: createdBy ?? this.createdBy,
    comment: comment ?? this.comment,
    createdAt: createdAt ?? this.createdAt,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          orgId == other.orgId &&
          projectId == other.projectId &&
          createdBy == other.createdBy &&
          comment == other.comment &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      Object.hash(id, orgId, projectId, createdBy, comment, createdAt);

  @override
  String toString() =>
      'CommentModel(id: $id, projectId: $projectId, createdBy: $createdBy)';
}
