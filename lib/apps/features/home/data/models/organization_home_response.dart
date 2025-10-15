import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twogass/apps/data/model/member_model.dart';
import 'package:twogass/apps/data/model/organitation_model.dart';
import 'package:twogass/apps/data/model/project_model.dart';

class OrganizationHomeResponseModel {
  final OrganizationModel org;
  final List<MemberModel>? members;
  final List<ProjectModel>? projects;

  const OrganizationHomeResponseModel({
    required this.org,
    this.members,
    this.projects,
  });

  factory OrganizationHomeResponseModel.fromFirestore(DocumentSnapshot doc) =>
      OrganizationHomeResponseModel.fromJson(
        doc.data()! as Map<String, dynamic>,
      );

  factory OrganizationHomeResponseModel.fromJson(Map<String, dynamic> json) =>
      OrganizationHomeResponseModel(
        org: OrganizationModel.fromJson(json['org'] as Map<String, dynamic>),
        members: json['members'] == null
            ? null
            : (json['members'] as List<dynamic>)
                  .map((e) => MemberModel.fromJson(e as Map<String, dynamic>))
                  .toList(),
        projects: json['projects'] == null
            ? null
            : (json['projects'] as List<dynamic>)
                  .map((e) => ProjectModel.fromJson(e as Map<String, dynamic>))
                  .toList(),
      );

  Map<String, dynamic> toJson() => {
    'org': org.toJson(),
    'members': members?.map((e) => e.toJson()).toList(),
    'projects': projects?.map((e) => e.toJson()).toList(),
  };

  factory OrganizationHomeResponseModel.fromMap(Map<String, dynamic> map) =>
      OrganizationHomeResponseModel(
        org: OrganizationModel.fromMap(map['org'] as Map<String, dynamic>),
        members: map['members'] == null
            ? null
            : (map['members'] as List<dynamic>)
                  .map((e) => MemberModel.fromMap(e as Map<String, dynamic>))
                  .toList(),
        projects: map['projects'] == null
            ? null
            : (map['projects'] as List<dynamic>)
                  .map((e) => ProjectModel.fromMap(e as Map<String, dynamic>))
                  .toList(),
      );

  Map<String, dynamic> toMap() => {
    'org': org.toMap(),
    'members': members?.map((e) => e.toMap()).toList(),
    'projects': projects?.map((e) => e.toMap()).toList(),
  };

  OrganizationHomeResponseModel copyWith({
    OrganizationModel? org,
    List<MemberModel>? members,
    List<ProjectModel>? projects,
  }) => OrganizationHomeResponseModel(
    org: org ?? this.org,
    members: members ?? this.members,
    projects: projects ?? this.projects,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrganizationHomeResponseModel &&
          runtimeType == other.runtimeType &&
          org == other.org &&
          members == other.members &&
          projects == other.projects;

  @override
  int get hashCode => Object.hash(org, members, projects);

  @override
  String toString() =>
      'OrganizationHomeResponseModel(org: $org, members: ${members?.length}, projects: ${projects?.length}})';
}
