import 'package:twogass/apps/data/model/comment_model.dart';
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
  Future<void> updateProject(ProjectModel model);
  Future<void> deleteTask(TaskModel task);
  Future<void> deleteProject(ProjectModel model);
  Future<void> addComment({required CommentModel model});
  Future<List<CommentModel>> getComment(String projectId);
}
