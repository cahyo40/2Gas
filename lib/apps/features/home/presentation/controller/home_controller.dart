import 'package:get/get.dart';
import 'package:twogass/apps/routes/route_names.dart';
import 'package:yo_ui/yo_ui.dart';

class HomeController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();

  addOrganization() {
    Get.back();
    Get.toNamed(RouteNames.ORGANIZATION_CREATE_UPDATE);
  }

  joinOrganization() {
    YoLogger.warning("Join Org");
  }

  detailOrganization(String orgId) {
    Get.toNamed(RouteNames.ORGANIZATION, arguments: {"id": orgId});
  }
}
