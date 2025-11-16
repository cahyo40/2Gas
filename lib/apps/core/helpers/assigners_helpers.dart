import 'package:twogass/apps/core/services/firebase.dart';
import 'package:twogass/apps/data/model/project_category_model.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:yo_ui/yo_ui_base.dart';

class AssignersHelpers {
  static Future<List<ProjectAssignModel>> project({
    required String projectId,
  }) async {
    try {
      final res = await FirebaseServices.projectAssign
          .where("projectId", isEqualTo: projectId)
          .get();
      return res.docs
          .map((doc) => ProjectAssignModel.fromFirestore(doc))
          .toList();
    } catch (e, s) {
      YoLogger.error("Get Project Assigner Error :$e -> $s");
      return [];
    }
  }

  static Future<List<TaskAssignModel>> task({required String taskId}) async {
    try {
      final res = await FirebaseServices.taskAssign
          .where("taskId", isEqualTo: taskId)
          .get();
      return res.docs.map((doc) => TaskAssignModel.fromFirestore(doc)).toList();
    } catch (e, s) {
      YoLogger.error("Get Task Assigner Error :$e -> $s");
      return [];
    }
  }

  static Future<List<ProjectCategoryModel>> categories({
    required String orgId,
  }) async {
    try {
      final res = await FirebaseServices.category
          .where("orgId", isEqualTo: orgId)
          .get();
      return res.docs
          .map((doc) => ProjectCategoryModel.fromFirestore(doc))
          .toList();
    } catch (e, s) {
      YoLogger.error("Get Category Error :$e -> $s");
      return [];
    }
  }
}
