import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/data/model/organitation_model.dart';
import 'package:twogass/apps/features/home/domain/usecase/get_organization_by_code_usecase.dart';
import 'package:twogass/apps/features/home/domain/usecase/join_organization_usecase.dart';
import 'package:twogass/apps/features/organization_create_update/domain/repositories/organization_create_update_repository.dart';
import 'package:twogass/apps/features/organization_create_update/domain/usecase/organization_create_update_usecase.dart';
import 'package:yo_ui/yo_ui.dart';

class OrganizationCreateUpdateController extends GetxController {
  OrganizationCreateUpdateUsecase createOrg = OrganizationCreateUpdateUsecase(
    Get.find<OrganizationCreateUpdateRepository>(),
  );
  GetOrganizationByCodeUsecase getOrgByCode = GetOrganizationByCodeUsecase(
    Get.find(),
  );
  JoinOrganizationUsecase joinOrg = JoinOrganizationUsecase(Get.find());

  final uid = Get.find<AuthController>().uid;
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();
  final isEdit = false.obs;
  final Rxn orgId = Rxn();

  final formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final desc = TextEditingController();
  final address = TextEditingController();
  final email = TextEditingController();
  final imagesUrl = "".obs;
  final Rxn<File> imageFile = Rxn<File>();
  final Rx<Color> colors = Get.context!.primaryColor.obs;

  final RxList<OrganizationModel> orgs = <OrganizationModel>[].obs;

  onSubmit() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        final id = YoIdGenerator.alphanumericId(length: 16);
        final inviteCode = YoIdGenerator.alphanumericId(
          length: 6,
        ).toUpperCase();

        final model = OrganizationModel(
          id: id,
          inviteCode: inviteCode,
          name: title.text.trim(),
          createdBy: uid,
          address: address.text.trim(),
          color: colors.value.toARGB32(),
          description: desc.text.trim(),
          email: email.text.trim(),
          createdAt: DateTime.now(),
        );

        await createOrg(model);
        Get.back(result: true);
      } catch (e, s) {
        YoSnackBar.show(
          context: Get.context!,
          message: "Error : $e -> $s",
          type: YoSnackBarType.error,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  onGetOrgByCode(String orgCode) async {
    isLoading.value = true;
    try {
      orgs.value = await getOrgByCode(orgCode);
      orgs.refresh();
    } catch (_) {
    } finally {
      isLoading.value = false;
    }
  }

  onJoinOrg(String orgId) async {
    await joinOrg(orgId);
  }

  @override
  void onInit() {
    final args = Get.arguments;
    if (args is Map<String, dynamic> && args['id'] != null) {
      orgId.value = args['id'] as String;
      isEdit.value = true;
    } else {
      isEdit.value = false;
      // opsional: kembali atau tampilkan error
    }
    super.onInit();
  }

  @override
  void onClose() {
    title.dispose();
    desc.dispose();
    address.dispose();
    email.dispose();
    super.onClose();
  }
}
