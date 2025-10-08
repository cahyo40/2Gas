import 'package:get/get.dart';

class TaskController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();
}
