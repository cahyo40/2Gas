abstract class ProjectRepository {
  Future<Map<String, dynamic>> projectResponse({
    required String id,
    String? orgId,
  });
}
