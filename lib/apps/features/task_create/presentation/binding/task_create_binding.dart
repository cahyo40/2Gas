import 'package:get/get.dart';

import '../controller/task_create_controller.dart';

class TaskCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskCreateController>(
      () => TaskCreateController(),
    );
  }
}
