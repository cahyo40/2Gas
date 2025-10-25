import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectCategoryModel {
  final String id;
  final String orgId;
  final String name;

  const ProjectCategoryModel({
    required this.id,
    required this.orgId,
    required this.name,
  });

  factory ProjectCategoryModel.initial() =>
      const ProjectCategoryModel(id: '', orgId: '', name: '');

  factory ProjectCategoryModel.fromFirestore(DocumentSnapshot doc) =>
      ProjectCategoryModel.fromJson(doc.data()! as Map<String, dynamic>);

  factory ProjectCategoryModel.fromJson(Map<String, dynamic> json) =>
      ProjectCategoryModel(
        id: json['id'] as String,
        orgId: json['orgId'] as String,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {'id': id, 'orgId': orgId, 'name': name};

  factory ProjectCategoryModel.fromMap(Map<String, dynamic> map) =>
      ProjectCategoryModel(
        id: map['id'] as String,
        orgId: map['orgId'] as String,
        name: map['name'] as String,
      );

  Map<String, dynamic> toMap() => {'id': id, 'orgId': orgId, 'name': name};

  ProjectCategoryModel copyWith({String? id, String? orgId, String? name}) =>
      ProjectCategoryModel(
        id: id ?? this.id,
        orgId: orgId ?? this.orgId,
        name: name ?? this.name,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectCategoryModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          orgId == other.orgId &&
          name == other.name;

  @override
  int get hashCode => Object.hash(id, orgId, name);

  @override
  String toString() =>
      'ProjectCategoryModel(id: $id, orgId: $orgId, name: $name)';
}
