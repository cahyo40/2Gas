import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/features/project/domain/repositories/project_repository.dart';

class UpdateProjectUsecase {
  final ProjectRepository _r;
  UpdateProjectUsecase(this._r);

  Future<void> call(ProjectModel model) => _r.updateProject(model);
}
