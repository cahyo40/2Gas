import 'package:get/get.dart';
import 'package:twogass/apps/core/services/sembast.dart';
import 'package:twogass/apps/features/home/data/datasource/home_network_datasource.dart';
import 'package:twogass/apps/features/home/data/datasource/home_offline_datasource.dart';
import 'package:twogass/apps/features/home/data/repositories/home_repository_impl.dart';
import 'package:twogass/apps/features/home/domain/repositories/home_repository.dart';
import 'package:twogass/apps/features/login/data/datasource/login_network_datasource.dart';
import 'package:twogass/apps/features/login/data/datasource/login_offline_datasource.dart';
import 'package:twogass/apps/features/login/data/repositories/login_repository_impl.dart';
import 'package:twogass/apps/features/login/domain/repositories/login_repository.dart';
import 'package:twogass/apps/features/organization/data/datasource/organization_network_datasource.dart';
import 'package:twogass/apps/features/organization/data/datasource/organization_offline_datasource.dart';
import 'package:twogass/apps/features/organization/data/repositories/organization_repository_impl.dart';
import 'package:twogass/apps/features/organization/domain/repositories/organization_repository.dart';
import 'package:twogass/apps/features/organization_create_update/data/datasource/organization_create_update_network_datasource.dart';
import 'package:twogass/apps/features/organization_create_update/data/datasource/organization_create_update_offline_datasource.dart';
import 'package:twogass/apps/features/organization_create_update/data/repositories/organization_create_update_repository_impl.dart';
import 'package:twogass/apps/features/organization_create_update/domain/repositories/organization_create_update_repository.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    //service
    Get.putAsync<SembastService>(() async {
      final service = SembastService();
      await service.db; // buka DB sekali saja
      return service;
    }, permanent: true);
    // Get.put();

    // repository
    // LOGIN
    Get.lazyPut<LoginRepository>(
      () => LoginRepositoryImpl(
        Get.find<LoginNetworkDatasource>(),
        Get.find<LoginOfflineDatasource>(),
      ),
      fenix: true,
    );

    // Datasource
    // LOGIN OFFLINE
    Get.lazyPut<LoginOfflineDatasource>(
      () => LoginOfflineDatasource(),
      fenix: true,
    );
    // LOGIN ONLINE
    Get.lazyPut<LoginNetworkDatasource>(
      () => LoginNetworkDatasource(),
      fenix: true,
    );

    // HOME
    Get.lazyPut<HomeRepository>(
      () => HomeRepositoryImpl(
        Get.find<HomeNetworkDatasource>(),
        Get.find<HomeOfflineDatasource>(),
      ),
      fenix: true,
    );

    Get.lazyPut(() => HomeNetworkDatasource(), fenix: true);
    Get.lazyPut(() => HomeOfflineDatasource(), fenix: true);

    // ORGANIZATION
    Get.lazyPut<OrganizationRepository>(
      () => OrganizationRepositoryImpl(
        Get.find<OrganizationNetworkDatasource>(),
        Get.find<OrganizationOfflineDatasource>(),
      ),
      fenix: true,
    );

    Get.lazyPut(() => OrganizationNetworkDatasource(), fenix: true);
    Get.lazyPut(() => OrganizationOfflineDatasource(), fenix: true);

    // ORGANIZATION Create Update
    Get.lazyPut<OrganizationCreateUpdateRepository>(
      () => OrganizationCreateUpdateRepositoryImpl(
        Get.find<OrganizationCreateUpdateNetworkDatasource>(),
        Get.find<OrganizationCreateUpdateOfflineDatasource>(),
      ),
      fenix: true,
    );

    Get.lazyPut(() => OrganizationCreateUpdateNetworkDatasource(), fenix: true);
    Get.lazyPut(() => OrganizationCreateUpdateOfflineDatasource(), fenix: true);
  }
}
