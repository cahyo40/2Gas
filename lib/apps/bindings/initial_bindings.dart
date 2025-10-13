import 'package:get/get.dart';
import 'package:twogass/apps/core/services/sembast.dart';
import 'package:twogass/apps/features/login/data/datasource/login_network_datasource.dart';
import 'package:twogass/apps/features/login/data/datasource/login_offline_datasource.dart';
import 'package:twogass/apps/features/login/data/repositories/login_repository_impl.dart';
import 'package:twogass/apps/features/login/domain/repositories/login_repository.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    //service
    Get.put<SembastDatabase>(SembastDatabase());
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
      () => LoginOfflineDatasource(Get.find<SembastDatabase>()),
      fenix: true,
    );
    // LOGIN ONLINE
    Get.lazyPut<LoginNetworkDatasource>(
      () => LoginNetworkDatasource(),
      fenix: true,
    );
  }
}
