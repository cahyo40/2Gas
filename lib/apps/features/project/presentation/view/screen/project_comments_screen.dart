import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/project_controller.dart';

class ProjectCommentsScreen extends GetView<ProjectController> {
  const ProjectCommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Text('ProjectCommentsScreen is working'),
    );
  }
}
