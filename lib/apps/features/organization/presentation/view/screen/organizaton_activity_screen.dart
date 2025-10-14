import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/organization_controller.dart';

class OrganizatonActivityScreen extends GetView<OrganizationController> {
  const OrganizatonActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Text('OrganizatonActivityScreen is working'),
    );
  }
}
