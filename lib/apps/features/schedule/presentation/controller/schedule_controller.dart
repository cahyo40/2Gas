import 'package:get/get.dart';
import 'package:twogass/apps/data/model/schedule_model.dart';
import 'package:twogass/apps/features/schedule/domain/usecase/schedule_usecase.dart';
import 'package:yo_ui/yo_ui_base.dart';

class ScheduleController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();

  RxList<ScheduleModel> schedule = <ScheduleModel>[].obs;
  FetchScheduleUserUsecase fetchSchedule = FetchScheduleUserUsecase(Get.find());

  iniData({bool useLoading = true}) async {
    isLoading.value = useLoading;
    try {
      final res = await Future.wait([fetchSchedule()]);
      schedule.value = res[0];
    } catch (e) {
      YoLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
