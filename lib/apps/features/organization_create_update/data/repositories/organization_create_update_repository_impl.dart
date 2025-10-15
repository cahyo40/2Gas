import 'dart:async';

import 'package:twogass/apps/data/model/organitation_model.dart';

import '../../domain/repositories/organization_create_update_repository.dart';
import '../datasource/organization_create_update_network_datasource.dart';
import '../datasource/organization_create_update_offline_datasource.dart';

class OrganizationCreateUpdateRepositoryImpl
    implements OrganizationCreateUpdateRepository {
  final OrganizationCreateUpdateNetworkDatasource _network;
  final OrganizationCreateUpdateOfflineDatasource _offline;

  OrganizationCreateUpdateRepositoryImpl(this._network, this._offline);

  @override
  Future<bool> createOrganization(OrganizationModel model) async {
    unawaited(_offline.createOrganization(model));
    return await _network.createOrganization(model);
  }
}
