import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const String _dbPath = "product_db.db";
  static Database? _db;

  static Future<void> init() async {
    var dir = await getDatabasesPath();
    _db = await openDatabase("$dir/$_dbPath",
        onCreate: (Database db, int version) async {
      await db.execute("""
        CREATE TABLE product
         (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          price REAL,
          imageLink BLOB
        );
        """);
    }, version: 1);
  }

  static Database getDb() {
    if (_db == null) {
      throw Error();
    }

    return _db!;
  }
}
