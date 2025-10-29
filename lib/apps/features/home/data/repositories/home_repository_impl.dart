import 'package:twogass/apps/data/model/organitation_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/home/data/models/organization_home_response.dart';

import '../../domain/repositories/home_repository.dart';
import '../datasource/home_network_datasource.dart';
import '../datasource/home_offline_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeNetworkDatasource _network;
  final HomeOfflineDatasource _offline;

  HomeRepositoryImpl(this._network, this._offline);

  @override
  Future<List<OrganizationHomeResponseModel>> homeOrganization() async {
    return await _network.homeOrganization();
  }

  @override
  Future<List<TaskModel>> userTask() async {
    return await _network.userTask();
  }

  @override
  Future<List<OrganizationModel>> getOrganization(String orgCode) async {
    return await _network.getOrganization(orgCode);
  }

  @override
  Future<void> joinOrganization(String orgId) async {
    return await _network.joinOrganization(orgId);
  }

  @override
  Future<bool> isJoinOrganization(String orgId) async {
    return await _network.isJoinOrganization(orgId);
  }
}
