import 'package:get/get.dart';
import 'package:twogass/apps/data/model/activity_model.dart';
import 'package:twogass/apps/data/model/organitation_model.dart';
import 'package:twogass/apps/features/organization/domain/repositories/organization_repository.dart';
import 'package:twogass/apps/features/organization/domain/usecase/detail_activity_usecase.dart';
import 'package:twogass/apps/features/organization/domain/usecase/detail_organization_usecase.dart';
import 'package:twogass/apps/features/organization/presentation/view/screen/organizaton_activity_screen.dart';
import 'package:twogass/apps/features/organization/presentation/view/screen/organizaton_overview_screen.dart';
import 'package:twogass/apps/features/organization/presentation/view/screen/organizaton_project_screen.dart';
import 'package:twogass/apps/features/organization/presentation/view/screen/organizaton_settings_screen.dart';
import 'package:twogass/apps/features/organization/presentation/view/screen/organizaton_task_screen.dart';
import 'package:twogass/l10n/generated/app_localizations.dart';
import 'package:yo_ui/yo_ui.dart';

final tr = AppLocalizations.of(Get.context!)!;

class OrganizationController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();
  final initialTab = 0.obs;
  final orgId = "".obs;
  final org = OrganizationModel.initial().obs;
  final activity = <ActivityModel>[].obs;
  final colorIcon = Get.theme.primaryColor.toARGB32().obs;

  GetOrganizationUsecase getOrganizationUsecase = GetOrganizationUsecase(
    Get.find<OrganizationRepository>(),
  );
  DetailActivityUsecase getActivity = DetailActivityUsecase(
    Get.find<OrganizationRepository>(),
  );

  final tabView = [
    OrganizatonOverviewScreen(),
    OrganizatonProjectScreen(),
    OrganizatonTaskScreen(),
    OrganizatonActivityScreen(),
    OrganizatonSettingsScreen(),
  ];

  void changeTab(int i) {
    initialTab.value = i;
  }

  initOrg(String orgId) async {
    isLoading.value = true;
    try {
      org.value = await getOrganizationUsecase(orgId);
      activity.addAll(await getActivity(orgId));
    } catch (_) {
    } finally {
      isLoading.value = false;
    }
  }

  final filtersProject = ["all", "active", "completed", "overdue"];
  final currentFilterProject = 0.obs;

  changeFilterProject(int index) {
    currentFilterProject.value = index;
  }

  final filtersTask = ["all", "to-do", "in progress", 'done'];
  final currentFilterTask = 0.obs;
  changeFilterTask(int index) {
    currentFilterTask.value = index;
  }

  @override
  void onInit() {
    final args = Get.arguments;
    if (args is Map<String, dynamic> && args['id'] != null) {
      orgId.value = args['id'] as String;
      YoLogger.info('Org ID: ${orgId.value}');
      initOrg(orgId.value);
    } else {
      YoLogger.error('Argumen "id" tidak ditemukan atau null');
      // opsional: kembali atau tampilkan error
    }

    ever(org, (_) {
      colorIcon.value = org.value.color ?? Get.context!.primaryColor.toARGB32();
    });

    super.onInit();
  }
}
