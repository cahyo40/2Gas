import 'package:twogass/apps/data/model/task_model.dart';

import '../repositories/task_create_repository.dart';

class TaskCreateUsecase {
  final TaskCreateRepository _repo;

  TaskCreateUsecase(this._repo);

  Future<bool> call(TaskModel task) async {
    return await _repo.createTask(task);
  }
}
