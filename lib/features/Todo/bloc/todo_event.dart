part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoEventLoad extends TodoEvent {}

class TodoEventAction extends TodoEvent {}

class TodoEventAdd extends TodoEventAction {
  final Todo todoToAdd;
  TodoEventAdd({required this.todoToAdd});
}

class TodoEventDelete extends TodoEventAction {
  final String uuidToDelete;
  TodoEventDelete({required this.uuidToDelete});
}
