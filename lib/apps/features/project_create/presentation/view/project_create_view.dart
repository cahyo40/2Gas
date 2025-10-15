import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/project_create_controller.dart';

class ProjectCreateView extends GetView<ProjectCreateController> {
  const ProjectCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('ProjectCreateView'.tr),
          centerTitle: true,
        ),
        body: const SafeArea(
          child: Text(
            'ProjectCreateView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
