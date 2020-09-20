import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/entities/todo.dart';

class AppDatabase {
  AppDatabase._();

  static AppDatabase _instance;
  Database _database;

  static AppDatabase get instance {
    _instance ??= AppDatabase._();
    return instance;
  }

  Future<Database> get database async {
    return await openDatabase(join(await getDatabasesPath(), "db_todo_app"),
        onCreate: (db, version) async {
      await db.execute(Todo.createQuery);
    }, onUpgrade: (db, oldVersion, newVersion) {});
  }

  Future<int> insertTodo(Todo todo) async {
    _database = await database;
    return await _database.insert('todo', todo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateTodo(Todo todo) async {
    _database = await database;
    return await _database.update('todo', todo.toJson(),
        where: 'title = ?', whereArgs: [todo.title]);
  }

  Future<int> deleteTodo(Todo todo) async {
    _database = await database;
    return await _database.delete('todo', where: 'title = ?', whereArgs: [todo.title]);
  }

}
