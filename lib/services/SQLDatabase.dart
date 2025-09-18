import 'package:online_course/services/ApiService.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLDatabase {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE store (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            category TEXT,
            lat REAL,
            lng REAL,
            rating REAL,
            price_level INTEGER,
            price INTEGER,
            hero_image TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE mycollection (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            product_id INTEGER,
            is_fav INTEGER,
            is_cart INTEGER
          )
        ''');
      },
    );
  }

  /// Contoh: sync data dari API ke SQLite
  static Future<void> syncStoresFromApi() async {
    final stores = await ApiService.getStores();
    final db = await database;

    for (var store in stores) {
      await db.insert(
        'store',
        store,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}
