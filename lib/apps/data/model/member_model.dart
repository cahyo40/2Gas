import 'package:cloud_firestore/cloud_firestore.dart';

class MemberModel {
  final String id;
  final String uid;
  final String orgId;
  final String role;
  final String imageUrl;
  final bool isPending;
  final DateTime? joinedAt;

  const MemberModel({
    required this.id,
    required this.uid,
    required this.orgId,
    required this.role,
    required this.imageUrl,
    this.isPending = true,
    this.joinedAt,
  });

  factory MemberModel.initial() => MemberModel(
    id: '',
    uid: '',
    orgId: '',
    imageUrl: '',
    role: 'member',
    isPending: true,
    joinedAt: null,
  );

  factory MemberModel.fromFirestore(DocumentSnapshot doc) =>
      MemberModel.fromJson(doc.data()! as Map<String, dynamic>);

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
    id: json['id'] as String,
    uid: json['uid'] as String,
    orgId: json['orgId'] as String,
    role: json['role'] as String,
    imageUrl: json['imageUrl'],
    isPending: json['isPending'] as bool,
    joinedAt: json['joinedAt'] == null ? null : _dtFromJson(json['joinedAt']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'uid': uid,
    'orgId': orgId,
    'role': role,
    'imageUrl': imageUrl,
    'isPending': isPending,
    'joinedAt': joinedAt == null ? null : _dtToJson(joinedAt!),
  };

  factory MemberModel.fromMap(Map<String, dynamic> map) => MemberModel(
    id: map['id'] as String,
    uid: map['uid'] as String,
    orgId: map['orgId'] as String,
    role: map['role'] as String,
    imageUrl: map['imageUrl'] as String,
    isPending: map['isPending'] as bool,
    joinedAt: map['joinedAt'] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(map['joinedAt'] as int),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'uid': uid,
    'orgId': orgId,
    'role': role,
    'imageUrl': imageUrl,
    'isPending': isPending,
    'joinedAt': joinedAt?.millisecondsSinceEpoch,
  };

  static int _dtToJson(DateTime dt) => dt.millisecondsSinceEpoch;
  static DateTime _dtFromJson(dynamic json) => json is int
      ? DateTime.fromMillisecondsSinceEpoch(json)
      : (json as Timestamp).toDate();

  MemberModel copyWith({
    String? id,
    String? uid,
    String? orgId,
    String? role,
    bool? isPending,
    String? imageUrl,
    DateTime? joinedAt,
  }) => MemberModel(
    id: id ?? this.id,
    imageUrl: imageUrl ?? this.imageUrl,
    uid: uid ?? this.uid,
    orgId: orgId ?? this.orgId,
    role: role ?? this.role,
    isPending: isPending ?? this.isPending,
    joinedAt: joinedAt ?? this.joinedAt,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          uid == other.uid &&
          orgId == other.orgId &&
          role == other.role &&
          imageUrl == other.imageUrl &&
          isPending == other.isPending &&
          joinedAt == other.joinedAt;

  @override
  int get hashCode => Object.hash(id, uid, orgId, role, isPending, joinedAt);

  @override
  String toString() =>
      'MemberModel(id: $id, uid: $uid, orgId: $orgId, isPending: $isPending)';
}
