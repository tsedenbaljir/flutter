import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableName = "users";
final String Column_id = "id";
final String Column_name = "name";
final String Column_job = "job";
final String Column_rent = "rent";
final String Column_date_rent = "date";

class TaskModel {
  int id;
  final String name;
  final String job;
  final String rent;

  TaskModel({this.id, this.name, this.job, this.rent});

  Map<String, dynamic> toMap() {
    return {
      Column_name: this.name,
      Column_job: this.job,
      Column_rent: this.rent
    };
  }
}

class TodoHelper {
  Database db;

  TodoHelper() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    db = await openDatabase(join(await getDatabasesPath(), "databses.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE $tableName($Column_id INTEGER PRIMARY KEY AUTOINCREMENT, $Column_name TEXT, $Column_job TEXT, $Column_rent TEXT, $Column_date_rent Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP)");
    }, version: 1);
  }

  Future<void> insertTask(TaskModel task) async {
    print(task.toString());
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
      return TaskModel(
        id: tasks[i][Column_id],
        name: tasks[i][Column_name],
        job: tasks[i][Column_name],
        rent: tasks[i][Column_rent],
      );
    });
  }
}
