import 'package:cloud_firestore/cloud_firestore.dart';

/// Pure-Dart model for a workspace user.
class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final DateTime createdAt;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.createdAt,
  });

  /* -------------------------------------------------
   * Initial / Empty
   * ------------------------------------------------- */
  factory UserModel.initial() => UserModel(
    uid: '',
    name: '',
    email: '',
    photoUrl: null,
    createdAt: DateTime.now(),
  );

  /* -------------------------------------------------
   * Firebase ⬄ Object
   * ------------------------------------------------- */
  factory UserModel.fromFirestore(DocumentSnapshot doc) =>
      UserModel.fromJson(doc.data()! as Map<String, dynamic>);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    uid: json['uid'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    photoUrl: json['photoUrl'] as String?,
    createdAt: _dtFromJson(json['createdAt']),
  );

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'email': email,
    'photoUrl': photoUrl,
    'createdAt': _dtToJson(createdAt),
  };

  /* -------------------------------------------------
   * Sembast ⬄ Object
   * ------------------------------------------------- */
  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    uid: map['uid'] as String,
    name: map['name'] as String,
    email: map['email'] as String,
    photoUrl: map['photoUrl'] as String?,
    createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
  );

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'name': name,
    'email': email,
    'photoUrl': photoUrl,
    'createdAt': createdAt.millisecondsSinceEpoch,
  };

  /* -------------------------------------------------
   * Helper
   * ------------------------------------------------- */
  static int _dtToJson(DateTime dt) => dt.millisecondsSinceEpoch;
  static DateTime _dtFromJson(dynamic json) => json is int
      ? DateTime.fromMillisecondsSinceEpoch(json)
      : (json as Timestamp).toDate();

  /* -------------------------------------------------
   * Copy
   * ------------------------------------------------- */
  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
    DateTime? createdAt,
  }) => UserModel(
    uid: uid ?? this.uid,
    name: name ?? this.name,
    email: email ?? this.email,
    photoUrl: photoUrl ?? this.photoUrl,
    createdAt: createdAt ?? this.createdAt,
  );

  /* -------------------------------------------------
   * Equality
   * ------------------------------------------------- */
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          name == other.name &&
          email == other.email &&
          photoUrl == other.photoUrl &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hash(uid, name, email, photoUrl, createdAt);

  @override
  String toString() => 'UserModel(uid: $uid, name: $name, email: $email)';
}
