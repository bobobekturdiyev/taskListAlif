import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task_list_alif/models/database_helper.dart';
import 'package:task_list_alif/models/task.dart';

class DatabaseService {
  Database? _database;
  DatabaseService() {}

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initialize();
    return _database!;
  }

  Future initialize() async {
    var databasePath = getDatabasesPath();
    var path = join(databasePath.toString(), DatabaseHelper.DB_NAME);

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
    return _database;
  }

  Future _createDB(Database db, int version) async {
    return await db.execute(
        "CREATE TABLE IF NOT EXISTS ${DatabaseHelper.TABLE_TASKS} (${DatabaseHelper.TASKS_COLUMNS[0]} INTEGER PRIMARY KEY AUTOINCREMENT, ${DatabaseHelper.TASKS_COLUMNS[1]} TEXT, ${DatabaseHelper.TASKS_COLUMNS[2]} INTEGER, ${DatabaseHelper.TASKS_COLUMNS[3]} VARCHAR(20) DEFAULT 'in_progress')");
  }

  Future<List<Task>> getAllTasks() async {
    final db = await database;
    final result =
        await db.rawQuery("SELECT * FROM ${DatabaseHelper.TABLE_TASKS}");
    return result.map((e) => Task.fromMap(e)).toList();
  }

  Future<List<Task>> getTasksByStatus(String status) async {
    final db = await database;

    final result = await db.rawQuery(
        "SELECT * FROM ${DatabaseHelper.TABLE_TASKS} WHERE `${DatabaseHelper.TASKS_COLUMNS[3]}` =?",
        [status]);

    return result.map((e) => Task.fromMap(e)).toList();
  }

  Future<Task> insert(Task task) async {
    final db = await database;
    final id = await db.insert(DatabaseHelper.TABLE_TASKS, task.toMap());
    return task.copy(id: id);
  }

  Future<void> delete(int id) async {
    final db = await database;
    await db
        .delete(DatabaseHelper.TABLE_TASKS, where: 'id = ?', whereArgs: [id]);
  }

  Future<Task> update(int id, Task task) async {
    final db = await database;
    await db.update(DatabaseHelper.TABLE_TASKS, task.toMap(),
        where: 'id = ?', whereArgs: [id]);
    return task.copy(title: task.title, status: task.status, date: task.date);
  }

  Future<void> updateStatus(int id, String status) async {
    final db = await database;
    var map = <String, dynamic>{
      DatabaseHelper.TASKS_COLUMNS[3]: status,
    };
    await db.update(DatabaseHelper.TABLE_TASKS, map,
        where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    await _database!.close();
  }
}
