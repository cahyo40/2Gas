import 'package:get/get.dart';

class BottomNavigationBarController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();

  final currentPage = 0.obs;

  void changePage(int i) {
    currentPage.value = i;
  }
}
