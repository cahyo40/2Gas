import 'package:get/get.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/features/login/data/models/login_model.dart';
import 'package:twogass/apps/features/login/domain/usecase/login_usecase.dart';

class LoginController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();

  final version = "0.0.0".obs;

  LoginUsecase loginUsecase = LoginUsecase(Get.find());
  AuthController get auth => Get.find<AuthController>();
  login() async {
    isLoading.value = true;
    try {
      await auth.signInWithGoogle();
      final initData = {
        'uid': auth.uid,
        'name': auth.name,
        'email': auth.email,
        'photoUrl': auth.photoUrl,
        'playerId': auth.playerId,
      };
      final data = LoginModel.fromMap(initData);
      await loginUsecase.call(data);
    } catch (_) {
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() async {
    // getVersion();
    super.onInit();
  }
}
