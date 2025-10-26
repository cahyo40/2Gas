import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/l10n/generated/app_localizations.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/task_create_controller.dart';

class FieldDescTaskScreen extends GetView<TaskCreateController> {
  const FieldDescTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YoTextFormField(
          controller: controller.desc,
          labelText: tr.field_description,
          inputStyle: YoInputStyle.modern,
          inputType: YoInputType.multiline,
          hintText: tr.field_description_hint,
          maxLines: null,
        ),
        SizedBox(height: YoSpacing.md),
      ],
    );
  }
}
