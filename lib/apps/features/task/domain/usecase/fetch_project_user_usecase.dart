import 'package:twogass/apps/data/model/project_model.dart';

import '../repositories/task_repository.dart';

class FetchProjectUserUsecase {
  final TaskRepository _repo;

  FetchProjectUserUsecase(this._repo);

  Future<List<ProjectModel>> call() => _repo.getProject();
}
