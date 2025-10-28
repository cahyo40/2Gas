import 'package:twogass/apps/data/model/task_model.dart';

import '../repositories/home_repository.dart';

class HomeTaskUsecase {
  final HomeRepository _repo;

  HomeTaskUsecase(this._repo);

  Future<List<TaskModel>> call() async {
    return await _repo.userTask();
  }
}
