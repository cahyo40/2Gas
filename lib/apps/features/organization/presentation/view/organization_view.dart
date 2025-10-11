import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/organization_controller.dart';

class OrganizationView extends GetView<OrganizationController> {
  const OrganizationView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('OrganizationView'.tr),
          centerTitle: true,
        ),
        body: const SafeArea(
          child: Text(
            'OrganizationView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
