import "package:totalbloc/models/todo.dart";

//this abstract class is the interface to store todos locally or remotely
abstract class TodoRepoInterface {
  Future<List<Todo>> fetchTodos();
  Future<int> addTodo(Todo todo);
  Future<int> removeTodo(String todoUuid);
  Future<int> deleteAllTodo();
  Future<int> favoriteTodo(String todoUuid);
  Future editTodo(Todo todo);
}
