import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/core/helpers/validation_helpers.dart';
import 'package:twogass/l10n/generated/app_localizations.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/task_create_controller.dart';

class FieldTitleTaskScreen extends GetView<TaskCreateController> {
  const FieldTitleTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YoTextFormField(
          fillColor: context.cardColor,
          controller: controller.title,
          labelText: tr.field_title,
          hintText: tr.field_title_hint,
          inputStyle: YoInputStyle.modern,
          validator: (value) =>
              YoFormValidation.required(value, field: tr.field_title),
        ),
        SizedBox(height: context.yoSpacingMd),
      ],
    );
  }
}
