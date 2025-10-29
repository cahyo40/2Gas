import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/data/model/organitation_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/home/data/models/organization_home_response.dart';
import 'package:twogass/apps/features/home/domain/repositories/home_repository.dart';
import 'package:twogass/apps/features/home/domain/usecase/get_organization_by_code_usecase.dart';
import 'package:twogass/apps/features/home/domain/usecase/home_org_usecase.dart';
import 'package:twogass/apps/features/home/domain/usecase/home_task_usecase.dart';
import 'package:twogass/apps/features/home/domain/usecase/is_joined_organization_usecase.dart';
import 'package:twogass/apps/features/home/domain/usecase/join_organization_usecase.dart';
import 'package:twogass/apps/features/home/presentation/view/screen/organization_join_screen.dart';
import 'package:twogass/apps/routes/route_names.dart';
import 'package:yo_ui/yo_ui.dart';

class HomeController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();
  final orgHome = <OrganizationHomeResponseModel>[].obs;
  final task = <TaskModel>[].obs;

  HomeOrgUsecase homeOrgUsecase = HomeOrgUsecase(Get.find<HomeRepository>());
  HomeTaskUsecase getUserTask = HomeTaskUsecase(Get.find<HomeRepository>());
  GetOrganizationByCodeUsecase getOrgByCode = GetOrganizationByCodeUsecase(
    Get.find(),
  );
  JoinOrganizationUsecase joinOrg = JoinOrganizationUsecase(Get.find());
  IsJoinedOrganizationUsecase isJoinOrg = IsJoinedOrganizationUsecase(
    Get.find(),
  );

  final RxList<OrganizationModel> orgs = <OrganizationModel>[].obs;
  final key = GlobalKey<FormState>();
  final code = TextEditingController();

  initOrg() async {
    orgHome.value = await homeOrgUsecase();
    task.value = await getUserTask();
    YoLogger.info(orgHome.toJson().toString());
  }

  addOrganization() {
    Get.back();
    Get.toNamed(RouteNames.ORGANIZATION_CREATE_UPDATE);
  }

  onGetOrgByCode(String orgCode) async {
    YoLogger.info("onGetOrgByCode");
    isLoading.value = true;
    try {
      YoLogger.info("Run");
      orgs.value = await getOrgByCode(orgCode.toUpperCase().trim());
      orgs.refresh();
    } catch (e, s) {
      YoLogger.error("$e - > $s");
    } finally {
      isLoading.value = false;
    }
  }

  onJoinOrg(String orgId) async {
    try {
      await joinOrg(orgId);
    } catch (_) {
    } finally {
      Get.back();
      YoSnackBar.show(
        context: Get.context!,
        message: "Tunggu persetujuan dahulu",
        type: YoSnackBarType.success,
      );
    }
  }

  joinOrganization() {
    Get.back();
    Get.to(OrganizationJoinScreen());
  }

  detailOrganization(String orgId) {
    // initOrg();
    Get.toNamed(RouteNames.ORGANIZATION, arguments: {"id": orgId});
  }

  @override
  void onInit() {
    initOrg();
    super.onInit();
  }
}
