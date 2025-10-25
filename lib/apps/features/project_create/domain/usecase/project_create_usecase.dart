import 'package:twogass/apps/data/model/project_model.dart';

import '../repositories/project_create_repository.dart';

class ProjectCreateUsecase {
  final ProjectCreateRepository _repo;

  ProjectCreateUsecase(this._repo);

  Future<bool> call(ProjectModel project) async {
    return await _repo.submitProject(project);
  }
}
