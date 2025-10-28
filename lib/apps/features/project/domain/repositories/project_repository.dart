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
}
