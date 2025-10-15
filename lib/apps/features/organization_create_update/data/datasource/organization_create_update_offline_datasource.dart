import 'package:get/get.dart';
import 'package:sembast/sembast_io.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/core/services/sembast.dart';
import 'package:twogass/apps/data/model/activity_model.dart';
import 'package:twogass/apps/data/model/member_model.dart';
import 'package:twogass/apps/data/model/organitation_model.dart';
import 'package:twogass/apps/features/organization_create_update/domain/repositories/organization_create_update_repository.dart';
import 'package:yo_ui/yo_ui.dart';

class OrganizationCreateUpdateOfflineDatasource
    implements OrganizationCreateUpdateRepository {
  OrganizationCreateUpdateOfflineDatasource();

  final user = Get.find<AuthController>();
  @override
  Future<bool> createOrganization(OrganizationModel model) async {
    try {
      final db = await SembastService.to.db;
      final memberId = YoIdGenerator.alphanumericId(length: 16);
      final activityId = YoIdGenerator.alphanumericId(length: 16);
      final now = DateTime.now();
      final meta = ActivityMeta(
        organizationName: model.name,
        memberName: user.name,
      );
      final member = MemberModel(
        id: memberId,
        uid: model.createdBy,
        orgId: model.id,
        role: "owner",
        isPending: false,
        joinedAt: now,
      );
      final activity = ActivityModel(
        id: activityId,
        orgId: model.id,
        title: "Created Organization",
        description: "",
        type: ActivityType.organizationCreated,
        createdAt: now,
        meta: meta,
        createdBy: model.createdBy,
      );

      await SembastService.org.record(model.id).put(db, model.toMap());
      await SembastService.activity
          .record(activityId)
          .put(db, activity.toMap());
      await SembastService.member.record(memberId).put(db, member.toMap());
      return true;
    } catch (e, s) {
      YoLogger.error('Unexpected error  $e-> $s');
      return false;
    }
  }
}
