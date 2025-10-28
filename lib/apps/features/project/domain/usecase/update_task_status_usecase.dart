import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/project/domain/repositories/project_repository.dart';

class UpdateTaskStatusUsecase {
  final ProjectRepository repository;

  UpdateTaskStatusUsecase(this.repository);

  Future<void> call({
    required String taskId,
    required TaskStatus status,
    required String projectId,
  }) {
    return repository.updateTaskStatus(
      taskId: taskId,
      status: status,
      projectId: projectId,
    );
  }
}
