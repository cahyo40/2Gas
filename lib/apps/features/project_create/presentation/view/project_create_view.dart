import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/features/project_create/presentation/view/screen/field_assigns_project_screen.dart';
import 'package:twogass/apps/features/project_create/presentation/view/screen/field_category_project_screen.dart';
import 'package:twogass/apps/features/project_create/presentation/view/screen/field_deadline_project_screen.dart';
import 'package:twogass/apps/features/project_create/presentation/view/screen/field_desc_project_screen.dart';
import 'package:twogass/apps/features/project_create/presentation/view/screen/field_priority_project_screen.dart';
import 'package:twogass/apps/features/project_create/presentation/view/screen/field_title_project_screen.dart';
import 'package:yo_ui/yo_ui.dart';

import '../controller/project_create_controller.dart';

class ProjectCreateView extends GetView<ProjectCreateController> {
  const ProjectCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: YoText.titleMedium('Create Project'),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.isLoading.isFalse
            ? SafeArea(
                child: Form(
                  key: controller.formKey,

                  child: ListView(
                    padding: YoPadding.all20,
                    children: [
                      FieldTitleProjectScreen(),
                      FieldCategoryProjectScreen(),
                      FieldDescProjectScreen(),
                      FieldAssignsProjectScreen(),
                      FieldPriorityProjectScreen(),
                      FieldDeadlineProjectScreen(),

                      YoButton.primary(
                        text: "Submit",
                        
                        onPressed: controller.onSumbit,
                        textColor: context.colorTextBtn,
                      ),
                    ],
                  ),
                ),
              )
            : Center(child: YoLoading()),
      ),
    );
  }
}
