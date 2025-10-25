import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/task_create_controller.dart';

class TaskCreateView extends GetView<TaskCreateController> {
  const TaskCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('TaskCreateView'.tr),
          centerTitle: true,
        ),
        body: const SafeArea(
          child: Text(
            'TaskCreateView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
