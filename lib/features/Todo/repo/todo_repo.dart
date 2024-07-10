import 'package:totalbloc/features/Todo/repo/todo_repo_interface.dart';
import 'package:totalbloc/features/Todo/repo/todo_repo_local_sqflite.dart';
import 'package:totalbloc/models/todo.dart';

// This is the main Repo implementation
// at the moment only TodoRepoLocalSqflite selection exists
// you may add conditional return for implemented repos
// you may have:
//  TodoRepoLocalHive
//  TodoRepoRemoteSupase
// etc, you may implement as:
//  Conditional RepoSelection - XXXXXXXXXXXX
// enum GlobalRepoSelection { localSqfLite, localHive, remoteSupabase }

// @override
// Future<int> addTodo(Todo todo) {
//   switch (GlobalRepoSelection) {
//     case GlobalRepoSelection.localSqfLite:
//       return  ;
//   }

//   return TodoRepoLocalSqflite().addTodo(todo);
// }

class TodoRepo extends TodoRepoInterface {
  @override
  Future<List<Todo>> fetchTodos() {
    return TodoRepoLocalSqflite().fetchTodos();
  }

  @override
  Future<int> addTodo(Todo todo) {
    return TodoRepoLocalSqflite().addTodo(todo);
  }

  @override
  Future<int> deleteAllTodo() {
    return TodoRepoLocalSqflite().deleteAllTodo();
  }

  @override
  Future editTodo(Todo todo) {
    return TodoRepoLocalSqflite().editTodo(todo);
  }

  @override
  Future<int> favoriteTodo(String todoUuid) {
    return TodoRepoLocalSqflite().favoriteTodo(todoUuid);
  }

  @override
  Future<int> removeTodo(String todoUuid) {
    return TodoRepoLocalSqflite().removeTodo(todoUuid);
  }
}
