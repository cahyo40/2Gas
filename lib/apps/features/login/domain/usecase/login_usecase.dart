import 'package:twogass/apps/features/login/data/models/login_model.dart';

import '../repositories/login_repository.dart';

class LoginUsecase {
  final LoginRepository _repo;

  LoginUsecase(this._repo);

  Future<void> call(LoginModel data) async => _repo.createUser(data);
}
