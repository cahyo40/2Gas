import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/organization_controller.dart';

class OrganizatonTaskScreen extends GetView<OrganizationController> {
  const OrganizatonTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Text('OrganizatonTaskScreen is working'),
    );
  }
}
