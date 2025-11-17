import 'package:twogass/apps/data/model/activity_model.dart';
import 'package:twogass/apps/data/model/member_model.dart';
import 'package:twogass/apps/data/model/organitation_model.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/schedule_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';

import '../../domain/repositories/organization_repository.dart';
import '../datasource/organization_network_datasource.dart';
import '../datasource/organization_offline_datasource.dart';

class OrganizationRepositoryImpl implements OrganizationRepository {
  final OrganizationNetworkDatasource _network;
  final OrganizationOfflineDatasource _offline;

  OrganizationRepositoryImpl(this._network, this._offline);

  @override
  Future<OrganizationModel> getOrganization(String orgId) async {
    return await _network.getOrganization(orgId);
  }

  @override
  Future<List<ActivityModel>> getActivity(String orgId) async {
    return await _network.getActivity(orgId);
  }

  @override
  Future<List<ProjectModel>> getProject(String orgId) async {
    return await _network.getProject(orgId);
  }

  @override
  Future<List<TaskModel>> getTask(String orgId, String? projectId) async {
    return await _network.getTask(orgId, projectId ?? "");
  }

  @override
  Future<List<MemberModel>> getMember(String orgId) async {
    return await _network.getMember(orgId);
  }

  @override
  Future<void> acceptMember(MemberModel memberId) async {
    return await _network.acceptMember(memberId);
  }

  @override
  Future<List<ScheduleModel>> getSchedule(String orgId) async {
    return await _network.getSchedule(orgId);
  }

  @override
  Future<void> changeRoleMember(MemberModel member, MemberRole role) async {
    return await _network.changeRoleMember(member, role);
  }

  @override
  Future<void> memberOut(MemberModel member, {bool isKick = false}) async {
    return _network.memberOut(member, isKick: isKick);
  }

  @override
  Future<void> deleteOrg(OrganizationModel model) async {
    return await _network.deleteOrg(model);
  }
}
