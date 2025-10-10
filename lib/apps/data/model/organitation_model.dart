import 'package:cloud_firestore/cloud_firestore.dart';

class OrganitationModel {
  final String id;
  final String inviteCode;
  final String name;
  final String? description;
  final String createdBy;
  final String? avatarUrl;
  final DateTime createdAt;
  final String? address;
  final String? email;

  const OrganitationModel({
    required this.id,
    required this.inviteCode,
    required this.name,
    this.description,
    required this.createdBy,
    this.avatarUrl,
    required this.createdAt,
    this.address,
    this.email,
  });

  factory OrganitationModel.fromFirestore(DocumentSnapshot doc) =>
      OrganitationModel.fromJson(doc.data()! as Map<String, dynamic>);

  factory OrganitationModel.fromJson(Map<String, dynamic> json) =>
      OrganitationModel(
        id: json['id'] as String,
        inviteCode: json['inviteCode'] as String,
        name: json['name'] as String,
        description: json['description'] as String?,
        createdBy: json['createdBy'] as String,
        avatarUrl: json['avatarUrl'] as String?,
        createdAt: _dateTimeFromJson(json['createdAt']),
        address: json['address'] as String?,
        email: json['email'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'inviteCode': inviteCode,
    'name': name,
    'description': description,
    'createdBy': createdBy,
    'avatarUrl': avatarUrl,
    'createdAt': _dateTimeToJson(createdAt),
    'address': address,
    'email': email,
  };

  factory OrganitationModel.fromMap(Map<String, dynamic> map) =>
      OrganitationModel(
        id: map['id'] as String,
        inviteCode: map['inviteCode'] as String,
        name: map['name'] as String,
        description: map['description'] as String?,
        createdBy: map['createdBy'] as String,
        avatarUrl: map['avatarUrl'] as String?,
        createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
        address: map['address'] as String?,
        email: map['email'] as String?,
      );

  Map<String, dynamic> toMap() => {
    'id': id,
    'inviteCode': inviteCode,
    'name': name,
    'description': description,
    'createdBy': createdBy,
    'avatarUrl': avatarUrl,
    'createdAt': createdAt.millisecondsSinceEpoch,
    'address': address,
    'email': email,
  };

  static int _dateTimeToJson(DateTime dt) => dt.millisecondsSinceEpoch;
  static DateTime _dateTimeFromJson(dynamic json) => json is int
      ? DateTime.fromMillisecondsSinceEpoch(json)
      : (json as Timestamp).toDate();

  OrganitationModel copyWith({
    String? id,
    String? inviteCode,
    String? name,
    String? description,
    String? createdBy,
    String? avatarUrl,
    DateTime? createdAt,
    String? address,
    String? email,
  }) => OrganitationModel(
    id: id ?? this.id,
    inviteCode: inviteCode ?? this.inviteCode,
    name: name ?? this.name,
    description: description ?? this.description,
    createdBy: createdBy ?? this.createdBy,
    avatarUrl: avatarUrl ?? this.avatarUrl,
    createdAt: createdAt ?? this.createdAt,
    address: address ?? this.address,
    email: email ?? this.email,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrganitationModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          inviteCode == other.inviteCode &&
          name == other.name &&
          description == other.description &&
          createdBy == other.createdBy &&
          avatarUrl == other.avatarUrl &&
          createdAt == other.createdAt &&
          address == other.address &&
          email == other.email;

  @override
  int get hashCode => Object.hash(
    id,
    inviteCode,
    name,
    description,
    createdBy,
    avatarUrl,
    createdAt,
    address,
    email,
  );

  @override
  String toString() =>
      'OrganitationModel(id: $id, inviteCode: $inviteCode, name: $name)';
}
