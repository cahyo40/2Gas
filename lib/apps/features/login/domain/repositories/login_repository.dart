import 'package:twogass/apps/features/login/data/models/login_model.dart';

abstract class LoginRepository {
  Future<void> createUser(LoginModel data);
}
