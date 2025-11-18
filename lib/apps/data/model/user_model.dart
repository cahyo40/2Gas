import 'package:cloud_firestore/cloud_firestore.dart';

/* ----------------- USER MODEL ----------------- */
class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final DateTime createdAt;
  final String playerId; // <<< NEW REQUIRED FIELD

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.createdAt,
    required this.playerId, // <<< REQUIRED
  });

  factory UserModel.initial() => UserModel(
    uid: '',
    name: '',
    email: '',
    photoUrl: null,
    createdAt: DateTime.now(),
    playerId: '', // <<< INITIAL EMPTY
  );

  //  FIREBASE  ⬄  OBJECT
  factory UserModel.fromFirestore(DocumentSnapshot doc) =>
      UserModel.fromJson(doc.data()! as Map<String, dynamic>);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    uid: json['uid'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    photoUrl: json['photoUrl'] as String?,
    createdAt: _dtFromJson(json['createdAt']),
    playerId: json['playerId'] as String,
  );

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'email': email,
    'photoUrl': photoUrl,
    'createdAt': _dtToJson(createdAt),
    'playerId': playerId,
  };

  //  SEMBAST  ⬄  OBJECT
  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    uid: map['uid'] as String,
    name: map['name'] as String,
    email: map['email'] as String,
    photoUrl: map['photoUrl'] as String?,
    createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    playerId: map['playerId'] as String,
  );

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'name': name,
    'email': email,
    'photoUrl': photoUrl,
    'createdAt': createdAt.millisecondsSinceEpoch,
    'playerId': playerId,
  };

  /* ---------------  HELPERS  --------------- */
  static int _dtToJson(DateTime dt) => dt.millisecondsSinceEpoch;
  static DateTime _dtFromJson(dynamic json) => json is int
      ? DateTime.fromMillisecondsSinceEpoch(json)
      : (json as Timestamp).toDate();

  /* ---------------  COPY  --------------- */
  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
    DateTime? createdAt,
    String? playerId,
  }) => UserModel(
    uid: uid ?? this.uid,
    name: name ?? this.name,
    email: email ?? this.email,
    photoUrl: photoUrl ?? this.photoUrl,
    createdAt: createdAt ?? this.createdAt,
    playerId: playerId ?? this.playerId,
  );

  /* ---------------  EQUALITY  --------------- */
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          name == other.name &&
          email == other.email &&
          photoUrl == other.photoUrl &&
          createdAt == other.createdAt &&
          playerId == other.playerId;

  @override
  int get hashCode =>
      Object.hash(uid, name, email, photoUrl, createdAt, playerId);

  @override
  String toString() =>
      'UserModel(uid: $uid, name: $name, email: $email, playerId: $playerId)';
}
