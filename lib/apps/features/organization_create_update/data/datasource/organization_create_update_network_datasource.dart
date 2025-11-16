import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/core/services/firebase.dart';
import 'package:twogass/apps/data/model/activity_model.dart';
import 'package:twogass/apps/data/model/member_model.dart';
import 'package:twogass/apps/data/model/organitation_model.dart';
import 'package:twogass/apps/features/organization_create_update/domain/repositories/organization_create_update_repository.dart';
import 'package:yo_ui/yo_ui.dart';

class OrganizationCreateUpdateNetworkDatasource
    implements OrganizationCreateUpdateRepository {
  AuthController get user => Get.find<AuthController>();
  @override
  Future<bool> createOrganization(OrganizationModel model) async {
    try {
      final memberId = YoIdGenerator.alphanumericId(length: 16);
      final activityId = YoIdGenerator.alphanumericId(length: 16);
      final now = DateTime.now();
      final meta = ActivityMeta(user: user.name, orgName: model.name);
      final member = MemberModel(
        name: user.name,
        email: user.email,
        id: memberId,
        uid: model.createdBy,
        orgId: model.id,
        role: MemberRole.owner,
        isPending: false,
        imageUrl: user.photoUrl,
        joinedAt: now,
      );
      final activity = ActivityModel(
        id: activityId,
        orgId: model.id,

        type: ActivityType.organizationCreated,
        createdAt: now,
        meta: meta,
        createdBy: model.createdBy,
      );

      await FirebaseServices.org.doc(model.id).set(model.toJson());
      await FirebaseServices.member.doc(memberId).set(member.toJson());
      await FirebaseServices.activity.doc(activityId).set(activity.toJson());

      return true;
    } on FirebaseException catch (e, s) {
      YoLogger.error('Firestore error $e -> $s');
      return false;
    } catch (e, s) {
      YoLogger.error('Unexpected error  $e-> $s');
      return false;
    }
  }
}
