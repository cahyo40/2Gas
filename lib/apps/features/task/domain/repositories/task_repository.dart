import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> getTask();
  Future<List<ProjectModel>> getProject();
}
