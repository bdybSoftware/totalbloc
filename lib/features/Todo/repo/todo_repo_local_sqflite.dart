import "package:totalbloc/features/pdebug.dart";
import "package:totalbloc/models/todo.dart";
import "package:totalbloc/features/sqflite_main_db_helper.dart"; // this is the place to create all necessary sqlite tables on onCreate method
import "package:sqflite/sqflite.dart";
import "package:sqflite_common/sqflite_logger.dart";
//import "package:sqflite/sqflite_dev.dart";
import 'package:path/path.dart';

// this class is responsible to store/manipulate todo data locally on device
// using sqflite as local storage for CRUD operations

class TodoRepoLocalSqflite {
  final String tableName = "Todo"; // this tableName should be same as
  // table name created at sqfliteTables in sqflite_main_db_helper.dart

  // all methods defined in TodoRepoInterface:
  // Future<int> addTodo(Todo todo);
  // Future<int> removeTodo(String todoUuid);
  // Future<int> deleteAllTodo();
  // Future<int> favoriteTodo(String todoUuid);
  // Future editTodo(Todo todo);

  Future<List<Todo>> fetchTodos() async {
    Database db = await MainDbHelper().initializeDB();
    pd("todo_repo_local.dart, fetchTodos()");
    List<Todo> allTodos = [];
    var result = await db.query(tableName);
    for (var element in result) {
      allTodos.add(Todo.fromSqflite(element));
    }
    return allTodos;
  }

  Future<int> addTodo(Todo todo) async {
    Database db = await MainDbHelper().initializeDB();
    pd("todo_repo_local.dart, addTodo()");
    int insert = await db.insert(tableName, todo.toSfqlite());
    return insert;
  }

  Future<int> removeTodo(String uuid) async {
    Database db = await MainDbHelper().initializeDB();
    pd("todo_repo_local.dart, removeTodo()");
    int remove =
        await db.delete(tableName, where: 'todoUuid = ?', whereArgs: [uuid]);
    return remove;
  }

  Future<int> deleteAllTodo() async {
    Database db = await MainDbHelper().initializeDB();
    pd("todo_repo_local.dart, deleteAllTodo()");

    List<Map<String, Object?>> dbResult = [];
    try {
      dbResult = await db.query(tableName);
    } on DatabaseException catch (e) {
      if (e.isNoSuchTableError()) {
        pd("todo_repo_local.dart, deleteAllTodo() SQL error no table, create and get it");
        // this is an example of try/catch for sqflite. normally our MainDbHelper() class creates all necessary tables
        // let's create tables if they are not existent:
        await MainDbHelper().onCreateForTryCatch();
        dbResult = await db.query(tableName);
      }
      // you may add other exeptions here continuing if block:
      // if (e.isDatabaseClosedError()) {
      //   pd("todo_repo_local.dart, deleteAllTodo() SQL database closed");
      //   Database db = await MainDbHelper().initializeDB();
      //   dbResult = await db.query(tableName);
      // }
    }
    int totalDeletedRows = await db.delete(tableName);
    return totalDeletedRows;
  }

  Future<int> favoriteTodo(String uuid) async {
    Database db = await MainDbHelper().initializeDB();
    pd("todo_repo_local.dart, favoriteTodo()");
    final record =
        await db.query(tableName, where: 'todoUuid = ?', whereArgs: [uuid]);
    Todo todo = Todo.fromSqflite(record[0]);
    todo = todo.copyWith(
        todoUuid: todo.todoUuid,
        todoName: todo.todoName,
        todoDescription: todo.todoDescription,
        todoFav: !todo.todoFav);
    int idNr = await db.update(tableName, todo.toSfqlite(),
        where: "todoUuid = ? ", whereArgs: [todo.todoUuid]);
    return idNr;
  }

  Future<int> editTodo(Todo todo) async {
    Database db = await MainDbHelper().initializeDB();
    pd("todo_repo_local.dart, editTodo()");

    int idNr = await db.update(tableName, todo.toSfqlite(),
        where: "todoUuid = ? ", whereArgs: [todo.todoUuid]);
    return idNr;
  }
}
