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
import 'package:twogass/apps/features/notifications/data/datasource/notifications_network_datasource.dart';
import 'package:twogass/apps/features/notifications/data/datasource/notifications_offline_datasource.dart';
import 'package:twogass/apps/features/notifications/data/repositories/notifications_repository_impl.dart';
import 'package:twogass/apps/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:twogass/apps/features/organization/data/datasource/organization_network_datasource.dart';
import 'package:twogass/apps/features/organization/data/datasource/organization_offline_datasource.dart';
import 'package:twogass/apps/features/organization/data/repositories/organization_repository_impl.dart';
import 'package:twogass/apps/features/organization/domain/repositories/organization_repository.dart';
import 'package:twogass/apps/features/organization_create_update/data/datasource/organization_create_update_network_datasource.dart';
import 'package:twogass/apps/features/organization_create_update/data/datasource/organization_create_update_offline_datasource.dart';
import 'package:twogass/apps/features/organization_create_update/data/repositories/organization_create_update_repository_impl.dart';
import 'package:twogass/apps/features/organization_create_update/domain/repositories/organization_create_update_repository.dart';
import 'package:twogass/apps/features/project/data/datasource/project_network_datasource.dart';
import 'package:twogass/apps/features/project/data/datasource/project_offline_datasource.dart';
import 'package:twogass/apps/features/project/data/repositories/project_repository_impl.dart';
import 'package:twogass/apps/features/project/domain/repositories/project_repository.dart';
import 'package:twogass/apps/features/project_create/data/datasource/project_create_network_datasource.dart';
import 'package:twogass/apps/features/project_create/data/datasource/project_create_offline_datasource.dart';
import 'package:twogass/apps/features/project_create/data/repositories/project_create_repository_impl.dart';
import 'package:twogass/apps/features/project_create/domain/repositories/project_create_repository.dart';
import 'package:twogass/apps/features/schedule/data/datasource/schedule_network_datasource.dart';
import 'package:twogass/apps/features/schedule/data/datasource/schedule_offline_datasource.dart';
import 'package:twogass/apps/features/schedule/data/repositories/schedule_repository_impl.dart';
import 'package:twogass/apps/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:twogass/apps/features/task/data/datasource/task_network_datasource.dart';
import 'package:twogass/apps/features/task/data/datasource/task_offline_datasource.dart';
import 'package:twogass/apps/features/task/data/repositories/task_repository_impl.dart';
import 'package:twogass/apps/features/task/domain/repositories/task_repository.dart';
import 'package:twogass/apps/features/task_create/data/datasource/task_create_network_datasource.dart';
import 'package:twogass/apps/features/task_create/data/datasource/task_create_offline_datasource.dart';
import 'package:twogass/apps/features/task_create/data/repositories/task_create_repository_impl.dart';
import 'package:twogass/apps/features/task_create/domain/repositories/task_create_repository.dart';

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

    // PROJECT
    Get.lazyPut<ProjectRepository>(
      () => ProjectRepositoryImpl(
        Get.find<ProjectNetworkDatasource>(),
        Get.find<ProjectOfflineDatasource>(),
      ),
      fenix: true,
    );

    Get.lazyPut(() => ProjectNetworkDatasource(), fenix: true);
    Get.lazyPut(() => ProjectOfflineDatasource(), fenix: true);
    // PROJECT Create
    Get.lazyPut<ProjectCreateRepository>(
      () => ProjectCreateRepositoryImpl(
        Get.find<ProjectCreateNetworkDatasource>(),
        Get.find<ProjectCreateOfflineDatasource>(),
      ),
      fenix: true,
    );

    Get.lazyPut(() => ProjectCreateNetworkDatasource(), fenix: true);
    Get.lazyPut(() => ProjectCreateOfflineDatasource(), fenix: true);
    // TASK CREATE
    Get.lazyPut<TaskCreateRepository>(
      () => TaskCreateRepositoryImpl(
        Get.find<TaskCreateNetworkDatasource>(),
        Get.find<TaskCreateOfflineDatasource>(),
      ),
      fenix: true,
    );

    Get.lazyPut(() => TaskCreateNetworkDatasource(), fenix: true);
    Get.lazyPut(() => TaskCreateOfflineDatasource(), fenix: true);
    // TASK USER
    Get.lazyPut<TaskRepository>(
      () => TaskRepositoryImpl(Get.find<TaskNetworkDatasource>()),
      fenix: true,
    );

    Get.lazyPut(() => TaskNetworkDatasource(), fenix: true);
    Get.lazyPut(() => TaskOfflineDatasource(), fenix: true);
    // SCHEDULE USER
    Get.lazyPut<ScheduleRepository>(
      () => ScheduleRepositoryImpl(Get.find<ScheduleNetworkDatasource>()),
      fenix: true,
    );

    Get.lazyPut(() => ScheduleNetworkDatasource(), fenix: true);
    Get.lazyPut(() => ScheduleOfflineDatasource(), fenix: true);

    // NOTIFICATION USER
    Get.lazyPut<NotificationsRepository>(
      () => NotificationsRepositoryImpl(
        Get.find<NotificationsNetworkDatasource>(),
      ),
      fenix: true,
    );

    Get.lazyPut(() => NotificationsNetworkDatasource(), fenix: true);
    Get.lazyPut(() => NotificationsOfflineDatasource(), fenix: true);
  }
}
