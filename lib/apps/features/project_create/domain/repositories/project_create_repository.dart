import 'package:twogass/apps/data/model/project_category_model.dart';
import 'package:twogass/apps/data/model/project_model.dart';

abstract class ProjectCreateRepository {
  Future<Map<String, dynamic>> getMemberCategory(String orgId);
  Future<bool> submitProject(ProjectModel project);
  Future<void> createCategory(ProjectCategoryModel categories);
}
