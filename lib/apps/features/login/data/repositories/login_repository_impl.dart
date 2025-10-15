import 'package:twogass/apps/features/login/data/models/login_model.dart';

import '../../domain/repositories/login_repository.dart';
import '../datasource/login_network_datasource.dart';
import '../datasource/login_offline_datasource.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginNetworkDatasource _network;
  final LoginOfflineDatasource _offline;

  LoginRepositoryImpl(this._network, this._offline);

  @override
  Future<void> createUser(LoginModel data) async {
    await _offline.createUser(data);
    await _network.createUser(data);
  }
}
