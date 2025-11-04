import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';

abstract class ProjectRepository {
  Future<Map<String, dynamic>> projectResponse({
    required String id,
    String? orgId,
  });

  Future<void> updateTaskStatus({
    required taskId,
    required String projectId,
    required TaskStatus status,
  });

  Future<void> addAssigner({required ProjectAssignModel model});
}
