import 'package:twogass/apps/core/services/firebase.dart';
import 'package:twogass/apps/features/login/data/models/login_model.dart';
import 'package:twogass/apps/features/login/domain/repositories/login_repository.dart';
import 'package:yo_ui/yo_ui_base.dart';

class LoginNetworkDatasource implements LoginRepository {
  @override
  Future<void> createUser(LoginModel data) async {
    YoLogger.info(data.toMap().toString());
    try {
      await FirebaseServices.users.doc(data.uid).set(data.toFirestore());
    } catch (e) {
      YoLogger.error(e.toString());
    }
  }
}
