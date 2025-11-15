import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/project/domain/repositories/project_repository.dart';

class DeleteTaskUsecase {
  final ProjectRepository _r;
  DeleteTaskUsecase(this._r);

  Future<void> call(TaskModel task) => _r.deleteTask(task);
}
