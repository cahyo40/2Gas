import 'package:twogass/apps/data/model/task_model.dart';

import '../repositories/task_repository.dart';

class FetchTaskUserUsecase {
  final TaskRepository _repo;

  FetchTaskUserUsecase(this._repo);

  Future<List<TaskModel>> call() => _repo.getTask();
}
