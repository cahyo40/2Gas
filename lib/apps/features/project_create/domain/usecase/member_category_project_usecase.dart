import '../repositories/project_create_repository.dart';

class GetMemberCategoryProjectUseCase {
  final ProjectCreateRepository _repo;

  GetMemberCategoryProjectUseCase(this._repo);

  Future<Map<String, dynamic>> call(String orgId) async {
    return await _repo.getMemberCategory(orgId);
  }
}
