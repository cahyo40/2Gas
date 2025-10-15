import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/data/model/organitation_model.dart';
import 'package:twogass/apps/features/organization_create_update/domain/repositories/organization_create_update_repository.dart';
import 'package:twogass/apps/features/organization_create_update/domain/usecase/organization_create_update_usecase.dart';
import 'package:yo_ui/yo_ui.dart';

class OrganizationCreateUpdateController extends GetxController {
  OrganizationCreateUpdateUsecase createOrg = OrganizationCreateUpdateUsecase(
    Get.find<OrganizationCreateUpdateRepository>(),
  );

  final uid = Get.find<AuthController>().uid;
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();
  final isEdit = false.obs;
  final Rxn orgId = Rxn();
  final ImagePicker _picker = ImagePicker();

  final formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final desc = TextEditingController();
  final address = TextEditingController();
  final email = TextEditingController();
  final imagesUrl = "".obs;
  final Rxn<File> imageFile = Rxn<File>();
  final Rx<Color> colors = Get.context!.primaryColor.obs;

  Future<void> onSelectLogo() async {
    var img = await _picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      imageFile.value = File(img.path);
    }
  }

  onSubmit() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        final id = YoIdGenerator.alphanumericId(length: 16);
        final inviteCode = YoIdGenerator.alphanumericId(
          length: 8,
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
        Get.back();
      } catch (e, s) {
        YoLogger.error('onSubmit error $e -> $s');
        Get.snackbar('Error', e.toString());
      } finally {
        isLoading.value = false;
      }
    }
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
