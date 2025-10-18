import '../repositories/project_repository.dart';

class ProjectUsecase {
  final ProjectRepository _repo;

  ProjectUsecase(this._repo);

  Future<Map<String, dynamic>> call(String id, String orgId) async {
    return await _repo.projectResponse(id: id, orgId: orgId);
  }
}
