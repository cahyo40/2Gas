import 'package:cloud_firestore/cloud_firestore.dart';

class MemberModel {
  final String id;
  final String uid;
  final String orgId;
  final String role;
  final String isPending;
  final DateTime joinedAt;

  const MemberModel({
    required this.id,
    required this.uid,
    required this.orgId,
    required this.role,
    required this.isPending,
    required this.joinedAt,
  });

  /* -------------------------------------------------
   * Firebase (Firestore) helpers
   * ------------------------------------------------- */
  factory MemberModel.fromFirestore(DocumentSnapshot doc) =>
      MemberModel.fromJson(doc.data()! as Map<String, dynamic>);

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
    id: json['id'] as String,
    uid: json['uid'] as String,
    orgId: json['orgId'] as String,
    role: json['role'] as String,
    isPending: json['isPending'] as String,
    joinedAt: _dateTimeFromJson(json['joinedAt']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'uid': uid,
    'orgId': orgId,
    'role': role,
    'isPending': isPending,
    'joinedAt': _dateTimeToJson(joinedAt),
  };

  /* -------------------------------------------------
   * Sembast helpers (Map<String,dynamic> dengan int)
   * ------------------------------------------------- */
  factory MemberModel.fromMap(Map<String, dynamic> map) => MemberModel(
    id: map['id'] as String,
    uid: map['uid'] as String,
    orgId: map['orgId'] as String,
    role: map['role'] as String,
    isPending: map['isPending'] as String,
    joinedAt: DateTime.fromMillisecondsSinceEpoch(map['joinedAt'] as int),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'uid': uid,
    'orgId': orgId,
    'role': role,
    'isPending': isPending,
    'joinedAt': joinedAt.millisecondsSinceEpoch,
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
  MemberModel copyWith({
    String? id,
    String? uid,
    String? orgId,
    String? role,
    String? isPending,
    DateTime? joinedAt,
  }) => MemberModel(
    id: id ?? this.id,
    uid: uid ?? this.uid,
    orgId: orgId ?? this.orgId,
    role: role ?? this.role,
    isPending: isPending ?? this.isPending,
    joinedAt: joinedAt ?? this.joinedAt,
  );

  /* -------------------------------------------------
   * Equality & hash
   * ------------------------------------------------- */
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          uid == other.uid &&
          orgId == other.orgId &&
          role == other.role &&
          isPending == other.isPending &&
          joinedAt == other.joinedAt;

  @override
  int get hashCode => Object.hash(id, uid, orgId, role, isPending, joinedAt);

  /* -------------------------------------------------
   * toString
   * ------------------------------------------------- */
  @override
  String toString() =>
      'MemberModel(id: $id, uid: $uid, orgId: $orgId, role: $role)';
}
