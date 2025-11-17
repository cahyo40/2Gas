import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/features/project/domain/repositories/project_repository.dart';

class DeleteProjectUsecase {
  final ProjectRepository _r;
  DeleteProjectUsecase(this._r);

  Future<void> call(ProjectModel model) => _r.deleteProject(model);
}
