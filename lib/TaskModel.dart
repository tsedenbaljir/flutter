import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableName = "todom";
final String Column_id = "id";
final String Column_name = "name";

class TaskModel {
  final String name;
  int id;

  TaskModel({this.name, this.id});

  Map<String, dynamic> toMap() {
    return {Column_name: this.name};
  }
}

class TodoHelper {
  Database db;

  TodoHelper() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    db = await openDatabase(join(await getDatabasesPath(), "databse.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE $tableName($Column_id INTEGER PRIMARY KEY AUTOINCREMENT, $Column_name TEXT)");
    }, version: 1);
  }

  Future<void> insertTask(TaskModel task) async {
    try {
      db.insert(tableName, task.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (_) {
      print(_);
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      db.delete(tableName,
          // Use a `where` clause to delete a specific dog.
          where: "id = ?",
          // Pass the Dog's id as a whereArg to prevent SQL injection.
          whereArgs: [id]);
    } catch (_) {
      print(_);
    }
  }

  Future<List<TaskModel>> getAllTask() async {
    final List<Map<String, dynamic>> tasks = await db.query(tableName);

    return List.generate(tasks.length, (i) {
      return TaskModel(name: tasks[i][Column_name], id: tasks[i][Column_id]);
    });
  }
}
