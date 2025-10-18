import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_ui/yo_ui.dart';

import '../controller/project_controller.dart';

class ProjectView extends GetView<ProjectController> {
  const ProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.isFalse
          ? Scaffold(
              appBar: AppBar(
                title: YoText.titleMedium(
                  controller.project.value.name.capitalize!,
                ),
                centerTitle: true,
              ),
              body: SafeArea(
                child: Text(
                  'ProjectView is working ${controller.id.value}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          : Scaffold(body: Center(child: YoLoading())),
    );
  }
}
