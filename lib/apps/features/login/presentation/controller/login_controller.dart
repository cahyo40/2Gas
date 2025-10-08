import 'package:get/get.dart';

class LoginController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();

  final version = "0.0.0".obs;

  // getVersion() async {
  //   final pack = await PackageInfo.fromPlatform();
  //   version.value = pack.version;
  // }

  @override
  void onInit() async {
    // getVersion();
    super.onInit();
  }
}
