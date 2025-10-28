import 'package:get/get.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/home/data/models/organization_home_response.dart';
import 'package:twogass/apps/features/home/domain/repositories/home_repository.dart';
import 'package:twogass/apps/features/home/domain/usecase/home_org_usecase.dart';
import 'package:twogass/apps/features/home/domain/usecase/home_task_usecase.dart';
import 'package:twogass/apps/routes/route_names.dart';
import 'package:yo_ui/yo_ui.dart';

class HomeController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();
  final orgHome = <OrganizationHomeResponseModel>[].obs;
  final task = <TaskModel>[].obs;

  HomeOrgUsecase homeOrgUsecase = HomeOrgUsecase(Get.find<HomeRepository>());
  HomeTaskUsecase getUserTask = HomeTaskUsecase(Get.find<HomeRepository>());

  initOrg() async {
    orgHome.value = await homeOrgUsecase();
    task.value = await getUserTask();
    YoLogger.info(orgHome.toJson().toString());
  }

  addOrganization() {
    Get.back();
    Get.toNamed(RouteNames.ORGANIZATION_CREATE_UPDATE);
  }

  joinOrganization() {
    YoLogger.warning("Join Org");
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
