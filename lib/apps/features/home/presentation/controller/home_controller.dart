import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/data/model/organitation_model.dart';
import 'package:twogass/apps/data/model/schedule_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/home/data/models/organization_home_response.dart';
import 'package:twogass/apps/features/home/domain/repositories/home_repository.dart';
import 'package:twogass/apps/features/home/domain/usecase/get_organization_by_code_usecase.dart';
import 'package:twogass/apps/features/home/domain/usecase/home_org_usecase.dart';
import 'package:twogass/apps/features/home/domain/usecase/home_task_usecase.dart';
import 'package:twogass/apps/features/home/domain/usecase/is_joined_organization_usecase.dart';
import 'package:twogass/apps/features/home/domain/usecase/join_organization_usecase.dart';
import 'package:twogass/apps/features/home/presentation/view/screen/organization_join_screen.dart';
import 'package:twogass/apps/features/schedule/domain/usecase/schedule_usecase.dart';
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
  FetchScheduleUserUsecase fetchSchedule = FetchScheduleUserUsecase(Get.find());

  final RxList<OrganizationModel> orgs = <OrganizationModel>[].obs;
  final RxList<ScheduleModel> schedules = <ScheduleModel>[].obs;
  final RxList<ScheduleModel> scheduleShow = <ScheduleModel>[].obs;
  final key = GlobalKey<FormState>();
  final code = TextEditingController();

  initOrg({bool useLoading = true}) async {
    isLoading.value = useLoading;
    try {
      final res = await Future.wait([
        homeOrgUsecase(),
        getUserTask(),
        fetchSchedule(),
      ]);
      orgHome.value = res[0] as List<OrganizationHomeResponseModel>;
      task.value = res[1] as List<TaskModel>;
      schedules.value = res[2] as List<ScheduleModel>;

      scheduleShow.value = schedules
          .where((e) => YoDateFormatter.isToday(e.date))
          .take(3)
          .toList();
      scheduleShow.refresh();
    } catch (e, s) {
      YoLogger.error("$e - $s");
    } finally {
      isLoading.value = false;
    }
  }

  addOrganization() async {
    Get.back();
    final result = await Get.toNamed(RouteNames.ORGANIZATION_CREATE_UPDATE);
    if (result == true) {
      YoSnackBar.show(
        context: Get.context!,
        message: "Berhasil membuat organisasi",
      );
      await initOrg(useLoading: true);
    }
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
      code.clear();
      Get.back();
      YoSnackBar.show(
        context: Get.context!,
        message: L10n.t.wait_for_approval,
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
