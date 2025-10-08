import 'package:get/get.dart';
import 'package:yo_ui/yo_ui.dart';

class NetworkController extends GetxController {
  bool isOffline = !YoConnectivity.isConnected;

  @override
  void onInit() {
    super.onInit();
    YoConnectivity.addListener(_listener);
  }

  @override
  void onClose() {
    YoConnectivity.removeListener(_listener);
    super.onClose();
  }

  void _listener(bool connected) {
    isOffline = !connected;
    update(); // rebuild GetBuilder
  }
}
