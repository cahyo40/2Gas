import 'package:get/get.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/core/services/firebase.dart';
import 'package:twogass/apps/data/model/schedule_model.dart';
import 'package:twogass/apps/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:yo_ui/yo_ui.dart';

class ScheduleNetworkDatasource implements ScheduleRepository {
  String get uid => Get.find<AuthController>().uid;
  @override
  Future<List<ScheduleModel>> getSchedule() async {
    try {
      final schedule = await FirebaseServices.schedule
          .where("uidAccess", arrayContains: uid)
          .get();
      final data = schedule.docs
          .map((doc) => ScheduleModel.fromFirestore(doc))
          .toList();
      return data;
    } catch (e, s) {
      YoLogger.error("$e -> $s");
      return [];
    }
  }
}
