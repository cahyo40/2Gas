import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/project_controller.dart';

class ProjectView extends GetView<ProjectController> {
  const ProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('ProjectView'.tr),
          centerTitle: true,
        ),
        body: const SafeArea(
          child: Text(
            'ProjectView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
