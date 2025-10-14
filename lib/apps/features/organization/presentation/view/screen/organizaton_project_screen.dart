import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/organization_controller.dart';

class OrganizatonProjectScreen extends GetView<OrganizationController> {
  const OrganizatonProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Text('OrganizatonProjectScreen is working'),
    );
  }
}
