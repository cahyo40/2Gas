/// ONE-FILE DROP-IN: MemberModel + UserModel + enums + helpers
/// Field `playerId` sudah ditambahkan dan dijadikan required.
import 'package:cloud_firestore/cloud_firestore.dart';

/* ----------------- ENUMS ----------------- */
enum MemberRole { owner, admin, member }

/* ----------------- MEMBER MODEL ----------------- */
class MemberModel {
  final String id;
  final String uid;
  final String name;
  final String email;
  final String orgId;
  final MemberRole role;
  final String imageUrl;
  final bool isPending;
  final DateTime? joinedAt;
  final String playerId; // <<< NEW REQUIRED FIELD

  const MemberModel({
    required this.id,
    required this.uid,
    required this.name,
    required this.email,
    required this.orgId,
    required this.role,
    required this.imageUrl,
    this.isPending = true,
    this.joinedAt,
    required this.playerId, // <<< REQUIRED
  });

  factory MemberModel.initial() => MemberModel(
    id: '',
    uid: '',
    name: '',
    email: '',
    orgId: '',
    role: MemberRole.member,
    imageUrl: '',
    isPending: true,
    joinedAt: null,
    playerId: '', // <<< INITIAL EMPTY
  );

  //  FIREBASE  ⬄  OBJECT
  factory MemberModel.fromFirestore(DocumentSnapshot doc) =>
      MemberModel.fromJson(doc.data()! as Map<String, dynamic>);

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
    id: json['id'] as String,
    uid: json['uid'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    orgId: json['orgId'] as String,
    role: _roleFromString(json['role'] as String),
    imageUrl: json['imageUrl'] as String,
    isPending: json['isPending'] as bool,
    joinedAt: json['joinedAt'] == null ? null : _dtFromJson(json['joinedAt']),
    playerId: json['playerId'] as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'uid': uid,
    'name': name,
    'email': email,
    'orgId': orgId,
    'role': role.name,
    'imageUrl': imageUrl,
    'isPending': isPending,
    'joinedAt': joinedAt == null ? null : _dtToJson(joinedAt!),
    'playerId': playerId,
  };

  //  SEMBAST  ⬄  OBJECT
  factory MemberModel.fromMap(Map<String, dynamic> map) => MemberModel(
    id: map['id'] as String,
    uid: map['uid'] as String,
    name: map['name'] as String,
    email: map['email'] as String,
    orgId: map['orgId'] as String,
    role: _roleFromString(map['role'] as String),
    imageUrl: map['imageUrl'] as String,
    isPending: map['isPending'] as bool,
    joinedAt: map['joinedAt'] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(map['joinedAt'] as int),
    playerId: map['playerId'] as String,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'uid': uid,
    'name': name,
    'email': email,
    'orgId': orgId,
    'role': role.name,
    'imageUrl': imageUrl,
    'isPending': isPending,
    'joinedAt': joinedAt?.millisecondsSinceEpoch,
    'playerId': playerId,
  };

  /* ---------------  HELPERS  --------------- */
  static int _dtToJson(DateTime dt) => dt.millisecondsSinceEpoch;
  static DateTime _dtFromJson(dynamic json) => json is int
      ? DateTime.fromMillisecondsSinceEpoch(json)
      : (json as Timestamp).toDate();

  static MemberRole _roleFromString(String val) => MemberRole.values.firstWhere(
    (e) => e.name == val,
    orElse: () => MemberRole.member,
  );

  /* ---------------  COPY  --------------- */
  MemberModel copyWith({
    String? id,
    String? uid,
    String? name,
    String? email,
    String? orgId,
    MemberRole? role,
    String? imageUrl,
    bool? isPending,
    DateTime? joinedAt,
    String? playerId,
  }) => MemberModel(
    id: id ?? this.id,
    uid: uid ?? this.uid,
    name: name ?? this.name,
    email: email ?? this.email,
    orgId: orgId ?? this.orgId,
    role: role ?? this.role,
    imageUrl: imageUrl ?? this.imageUrl,
    isPending: isPending ?? this.isPending,
    joinedAt: joinedAt ?? this.joinedAt,
    playerId: playerId ?? this.playerId,
  );

  /* ---------------  EQUALITY  --------------- */
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          uid == other.uid &&
          name == other.name &&
          email == other.email &&
          orgId == other.orgId &&
          role == other.role &&
          imageUrl == other.imageUrl &&
          isPending == other.isPending &&
          joinedAt == other.joinedAt &&
          playerId == other.playerId;

  @override
  int get hashCode => Object.hash(
    id,
    uid,
    name,
    email,
    orgId,
    role,
    imageUrl,
    isPending,
    joinedAt,
    playerId,
  );

  @override
  String toString() =>
      'MemberModel(id: $id, uid: $uid, name: $name, playerId: $playerId)';
}
