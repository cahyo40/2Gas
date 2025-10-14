import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/organization_controller.dart';

class OrganizatonSettingsScreen extends GetView<OrganizationController> {
  const OrganizatonSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Text('OrganizatonSettingsScreen is working'),
    );
  }
}
