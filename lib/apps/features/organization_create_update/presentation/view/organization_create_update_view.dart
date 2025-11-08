import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/features/organization_create_update/presentation/view/screen/organization_field_address_screen.dart';
import 'package:twogass/apps/features/organization_create_update/presentation/view/screen/organization_field_colors_screen.dart';
import 'package:twogass/apps/features/organization_create_update/presentation/view/screen/organization_field_desc_screen.dart';
import 'package:twogass/apps/features/organization_create_update/presentation/view/screen/organization_field_email_screen.dart';
import 'package:twogass/apps/features/organization_create_update/presentation/view/screen/organization_field_picture_screen.dart';
import 'package:twogass/apps/features/organization_create_update/presentation/view/screen/organization_field_title_screen.dart';
import 'package:yo_ui/yo_ui.dart';

import '../controller/organization_create_update_controller.dart';

class OrganizationCreateUpdateView
    extends GetView<OrganizationCreateUpdateController> {
  const OrganizationCreateUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: YoText.titleMedium(L10n.t.create_org)),
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: ListView(
            padding: YoPadding.all20,
            children: [
              OrganizationFieldTitleScreen(),
              OrganizationFieldEmailScreen(),
              OrganizationFieldAddressScreen(),
              Row(
                children: [
                  Expanded(child: OrganizationFieldPictureScreen()),
                  Expanded(child: OrganizationFieldColorsScreen()),
                ],
              ),
              OrganizationFieldDescScreen(),
              Obx(
                () => YoButton.primary(
                  text: L10n.t.submit,
                  isLoading: controller.isLoading.value,
                  textColor: context.onPrimaryColor,
                  onPressed: () {
                    controller.onSubmit();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
