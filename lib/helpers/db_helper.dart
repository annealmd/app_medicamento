import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'medicamentos.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_medicamentos(id INTEGER PRIMARY KEY, title TEXT, quantidade TEXT, dose TEXT, frequencia INTEGER, duracao INTEGER, dataInicio TEXT, horaInicio TEXT, isContinuo INTEGER)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();

    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table, orderBy: "id ASC");
  }

  static Future<void> getCount() async {
    //database connection
    final db = await DBHelper.database();
    var x = await db.rawQuery('SELECT COUNT (*) from user_medicamentos');
    print(x);
  }

  static  Future<void> deleteMedicamento(String table, int id) async {
  // Get a reference to the database.
  final db = await DBHelper.database();
  // Remove the Medicamentofrom the Database.
  await db.delete(
    table,
    // Use a `where` clause to delete a specific dog.
    where: "id = ?",
    // Pass the medicamento id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );
}

static Future<void> updateMedicamento(String table, Map<String, Object> data, int id) async {
  final db = await DBHelper.database();
  await db.update(table, data, where: 'id = ?', whereArgs: [id]);
}
}