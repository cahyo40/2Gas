import 'package:twogass/apps/data/model/project_category_model.dart';
import 'package:twogass/apps/data/model/project_model.dart';

import '../../domain/repositories/project_create_repository.dart';
import '../datasource/project_create_network_datasource.dart';
import '../datasource/project_create_offline_datasource.dart';

class ProjectCreateRepositoryImpl implements ProjectCreateRepository {
  final ProjectCreateNetworkDatasource _network;
  final ProjectCreateOfflineDatasource _offline;

  ProjectCreateRepositoryImpl(this._network, this._offline);

  @override
  Future<void> createCategory(ProjectCategoryModel categories) async {
    await _network.createCategory(categories);
  }

  @override
  Future<Map<String, dynamic>> getMemberCategory(String orgId) async {
    return _network.getMemberCategory(orgId);
  }

  @override
  Future<bool> submitProject(ProjectModel project) async {
    return _network.submitProject(project);
  }
}
