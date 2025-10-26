import 'package:twogass/apps/data/model/task_model.dart';

abstract class TaskCreateRepository {
  Future<bool> createTask(TaskModel task);
}
