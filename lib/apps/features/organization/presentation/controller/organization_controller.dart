import 'package:get/get.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/data/model/activity_model.dart';
import 'package:twogass/apps/data/model/member_model.dart';
import 'package:twogass/apps/data/model/organitation_model.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/features/home/presentation/controller/home_controller.dart';
import 'package:twogass/apps/features/organization/domain/repositories/organization_repository.dart';
import 'package:twogass/apps/features/organization/domain/usecase/accept_member_usecase.dart';
import 'package:twogass/apps/features/organization/domain/usecase/detail_activity_usecase.dart';
import 'package:twogass/apps/features/organization/domain/usecase/detail_organization_usecase.dart';
import 'package:twogass/apps/features/organization/domain/usecase/fetch_member_org_usecase.dart';
import 'package:twogass/apps/features/organization/domain/usecase/fetch_project_org_usecase.dart';
import 'package:twogass/apps/features/organization/domain/usecase/fetch_task_org_usecase.dart';
import 'package:twogass/l10n/generated/app_localizations.dart';
import 'package:yo_ui/yo_ui.dart';

final tr = AppLocalizations.of(Get.context!)!;
String get uid => Get.find<AuthController>().uid;

class OrganizationController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();
  final initialTab = 0.obs;
  final orgId = "".obs;
  final org = OrganizationModel.initial().obs;
  final activity = <ActivityModel>[].obs;

  final project = <ProjectModel>[].obs;
  final projectShow = <ProjectModel>[].obs;
  final task = <TaskModel>[].obs;
  final members = <MemberModel>[].obs;
  final membersShow = <MemberModel>[].obs;
  final myRole = MemberRole.member.obs;
  final isMemberPending = false.obs;

  final colorIcon = Get.theme.primaryColor.toARGB32().obs;

  GetOrganizationUsecase getOrganizationUsecase = GetOrganizationUsecase(
    Get.find<OrganizationRepository>(),
  );
  DetailActivityUsecase getActivity = DetailActivityUsecase(
    Get.find<OrganizationRepository>(),
  );
  FetchProjectOrgUsecase getProject = FetchProjectOrgUsecase(
    Get.find<OrganizationRepository>(),
  );
  FetchTaskOrgUsecase getTask = FetchTaskOrgUsecase(
    Get.find<OrganizationRepository>(),
  );

  AcceptMemberUsecase acceptMember = AcceptMemberUsecase(
    Get.find<OrganizationRepository>(),
  );

  FetchMemberOrgUsecase getMember = FetchMemberOrgUsecase(Get.find());

  void changeTab(int i) {
    initialTab.value = i;
  }

  initOrg(String orgId, {bool useLoading = true}) async {
    isLoading.value = useLoading;
    try {
      org.value = await getOrganizationUsecase(orgId);
      activity.value = await getActivity(orgId);
      project.value = await getProject(orgId);
      projectShow.value = project;
      task.value = await getTask(orgId, "");
      members.value = await getMember(orgId);

      myRole.value = members.where((d) => d.uid == uid).first.role;
    } catch (_) {
    } finally {
      isLoading.value = false;
    }
  }

  void membersFilter() {
    final filtered = members
        .where((mem) => mem.isPending == isMemberPending.value)
        .toList();

    // taruh diri-sendiri paling atas
    filtered.sort((a, b) {
      final aIsMe = a.uid == uid;
      final bIsMe = b.uid == uid;
      if (aIsMe && !bIsMe) return -1; // a duluan
      if (!aIsMe && bIsMe) return 1; // b duluan
      return 0; // urutan awal
    });

    membersShow.assignAll(filtered);
  }

  onAcceptMember(MemberModel model) async {
    await acceptMember(model);
    members.value = await getMember(orgId.value);
    initOrg(orgId.value, useLoading: false);
    YoSnackBar.show(
      context: Get.context!,
      message: "${model.name} join ${org.value.name}",
      type: YoSnackBarType.success,
    );
  }

  refreshProject() async {
    try {
      project.value = await getProject(orgId.value);
      projectShow.value = project;
    } catch (_) {}
  }

  final filtersProject = ["all", "active", "completed", "overdue"];
  final currentFilterProject = 0.obs;

  changeFilterProject(int index) {
    currentFilterProject.value = index;
    if (index == 0) {
      projectShow.value = project;
    } else {
      projectShow.value = project
          .where(
            (e) => e.status.name == filtersProject[currentFilterProject.value],
          )
          .toList();
    }

    projectShow.refresh();
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

  @override
  void onClose() async {
    await Get.find<HomeController>().initOrg();
    super.onClose();
  }
}
