import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/controller/network_controller.dart';
import 'package:yo_ui/yo_ui.dart';

class ConnectivityWidget extends StatelessWidget {
  const ConnectivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NetworkController>(
      init: NetworkController(),
      builder: (c) {
        if (c.isOffline) {
          return Container(
            width: double.infinity,
            color: context.errorColor,
            child: YoText.bodyMedium("offline"),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
