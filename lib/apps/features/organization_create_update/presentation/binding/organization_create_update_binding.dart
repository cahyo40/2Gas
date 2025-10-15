import 'package:get/get.dart';

import '../controller/organization_create_update_controller.dart';

class OrganizationCreateUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrganizationCreateUpdateController>(
      () => OrganizationCreateUpdateController(),
    );
  }
}
