import 'package:twogass/apps/data/model/activity_model.dart';
import 'package:twogass/apps/data/model/member_model.dart';
import 'package:twogass/apps/data/model/organitation_model.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/schedule_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';

abstract class OrganizationRepository {
  Future<OrganizationModel> getOrganization(String orgId);
  Future<List<ActivityModel>> getActivity(String orgId);
  Future<List<ProjectModel>> getProject(String orgId);
  Future<List<TaskModel>> getTask(String orgId, String? projectId);
  Future<List<MemberModel>> getMember(String orgId);
  Future<void> acceptMember(MemberModel member);
  Future<void> changeRoleMember(MemberModel member, MemberRole role);
  Future<void> memberOut(MemberModel member, {bool isKick = false});
  Future<List<ScheduleModel>> getSchedule(String orgId);
  Future<void> deleteOrg(OrganizationModel model);
}
