import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/l10n/generated/app_localizations.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/organization_create_update_controller.dart';

class OrganizationFieldAddressScreen
    extends GetView<OrganizationCreateUpdateController> {
  const OrganizationFieldAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YoTextFormField(
          controller: controller.address,
          readOnly: controller.isEdit.value,
          labelText: tr.field_address,
          inputStyle: YoInputStyle.modern,
          hintText: tr.field_address_hint,
        ),
        SizedBox(height: YoSpacing.md),
      ],
    );
  }
}
