import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final String dbPath = await sql.getDatabasesPath();
    //Step 1: create db if the db doesn't exist
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) async {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    },
        version:
            1); //open on finidng the file and if not found, will create the file
  }

  static Future<void> insert(
      String addToTable, Map<String, Object> dataToAdd) async {
    final sql.Database sqlDb = await DBHelper.database();
    await sqlDb.insert(addToTable, dataToAdd,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, Object?>>> getData(String table) async {
    final sql.Database sqlDb = await DBHelper.database();
    return sqlDb.query(table);
  }
}
