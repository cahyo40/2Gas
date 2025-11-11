import 'package:get/get.dart';
import 'package:twogass/apps/features/schedule/presentation/controller/schedule_controller.dart';
import 'package:twogass/apps/features/task/presentation/controller/task_controller.dart';

class BottomNavigationBarController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();

  final currentPage = 0.obs;

  void changePage(int i) {
    currentPage.value = i;
    if (i == 1) {
      Get.find<TaskController>().iniData();
      Get.find<TaskController>().resetFilter();
    }
    if (i == 2) {
      Get.find<ScheduleController>().iniData();
    }
  }
}
