import 'package:sembast/sembast_io.dart';
import 'package:twogass/apps/core/services/sembast.dart';
import 'package:twogass/apps/features/login/data/models/login_model.dart';
import 'package:twogass/apps/features/login/domain/repositories/login_repository.dart';
import 'package:yo_ui/yo_ui_base.dart';

class LoginOfflineDatasource implements LoginRepository {
  final SembastDatabase _db;

  LoginOfflineDatasource(this._db);

  @override
  Future<void> createUser(LoginModel data) async {
    try {
      final db = await _db.database;
      await SembastDatabase.user.record(data.uid).put(db, data.toMap());
    } catch (e) {
      YoLogger.error("Offline: $e");
    }
  }
}
