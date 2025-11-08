import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/features/project/domain/repositories/project_repository.dart';

class AddAssignerUsecase {
  final ProjectRepository _r;
  AddAssignerUsecase(this._r);

  Future<void> call(ProjectAssignModel model) => _r.addAssigner(model: model);
}
