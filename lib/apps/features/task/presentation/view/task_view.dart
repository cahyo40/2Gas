import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/task_controller.dart';

class TaskView extends GetView<TaskController> {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('TaskView'.tr),
          centerTitle: true,
        ),
        body: const SafeArea(
          child: Text(
            'TaskView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
