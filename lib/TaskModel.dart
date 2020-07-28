import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableName = "users";
final String Column_id = "id";
final String Column_name = "name";
final String Column_job = "job";
final String Column_rent = "rent";
final String Column_phone = "phone";
final String Column_most_phone = "most_phone";
final String Column_date_rent = "date";

class TaskModel {
  int id;
  final String name;
  final String job;
  final String rent;
  final String phone;
  final String most_phone;
  final DateTime date = DateTime.now();

  TaskModel({
    this.id,
    this.name,
    this.job,
    this.rent,
    this.phone,
    this.most_phone,
    date,
  });

  Map<String, dynamic> toMap() {
    return {
      Column_name: this.name,
      Column_job: this.job,
      Column_rent: this.rent,
      Column_phone: this.phone,
      Column_most_phone: this.most_phone,
    };
  }
}

class TodoHelper {
  Database db;

  TodoHelper() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    db = await openDatabase(join(await getDatabasesPath(), "tests.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE $tableName($Column_id INTEGER PRIMARY KEY AUTOINCREMENT, $Column_name TEXT, $Column_job TEXT, $Column_phone TEXT, $Column_most_phone TEXT, $Column_rent TEXT, $Column_date_rent DATETIME DEFAULT CURRENT_TIMESTAMP)");
    }, version: 1);
  }

  Future<void> insertTask(TaskModel task) async {
    print(task.toMap());
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
        job: tasks[i][Column_job],
        rent: tasks[i][Column_rent],
        phone: tasks[i][Column_phone],
        most_phone: tasks[i][Column_most_phone],
        date: tasks[i][Column_date_rent],
      );
    });
  }
}
