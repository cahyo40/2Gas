import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/core/helpers/validation_helpers.dart';
import 'package:twogass/l10n/generated/app_localizations.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/organization_create_update_controller.dart';

class OrganizationFieldEmailScreen
    extends GetView<OrganizationCreateUpdateController> {
  const OrganizationFieldEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YoTextFormField(
          fillColor: context.cardColor,
          inputStyle: YoInputStyle.modern,
          inputType: YoInputType.email,
          controller: controller.email,
          readOnly: controller.isEdit.value,
          labelText: "Email",
          validator: (value) => YoFormValidation.email(value),
          hintText: tr.field_email_hint,
        ),
        SizedBox(height: YoSpacing.md),
      ],
    );
  }
}
