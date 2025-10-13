import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:twogass/apps/core/constants/database.dart';

final collect = DatabaseConst();

class SembastDatabase {
  static Database? _db;

  Future<Database> get database async {
    _db ??= await init();
    return _db!;
  }

  Future<Database> init() async {
    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    final dbPath = join(dir.path, 'app.db');
    return databaseFactoryIo.openDatabase(dbPath);
  }

  static final StoreRef<String, Map<String, dynamic>> user =
      stringMapStoreFactory.store(collect.user);
  static final StoreRef<String, Map<String, dynamic>> org =
      stringMapStoreFactory.store(collect.org);
  static final StoreRef<String, Map<String, dynamic>> project =
      stringMapStoreFactory.store(collect.project);
  static final StoreRef<String, Map<String, dynamic>> task =
      stringMapStoreFactory.store(collect.task);
  static final StoreRef<String, Map<String, dynamic>> schedule =
      stringMapStoreFactory.store(collect.schedule);
  static final StoreRef<String, Map<String, dynamic>> notif =
      stringMapStoreFactory.store(collect.notification);
  static final StoreRef<String, Map<String, dynamic>> vote =
      stringMapStoreFactory.store(collect.voting);
}
