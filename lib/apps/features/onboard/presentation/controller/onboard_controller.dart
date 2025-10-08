import 'package:get/get.dart';

class OnboardController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();
}
