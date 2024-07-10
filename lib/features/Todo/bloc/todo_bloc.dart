import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:totalbloc/features/Todo/repo/todo_repo.dart';
import 'package:totalbloc/models/todo.dart';
import 'package:totalbloc/features/Todo/repo/todo_repo_interface.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoStateInitial()) {
    on<TodoEventLoad>((event, emit) async {
      emit(TodoStateFetchLoading());
      print("todo_bloc.dart, TodoEventLoad TRIGGERED");
      final List<Todo> fetchedTodos = await TodoRepo().fetchTodos();

      emit(TodoStateLoaded(fetchedTodos: fetchedTodos));
    });

    on<TodoEventAdd>(
      (event, emit) async {
        int result = await TodoRepo().addTodo(event.todoToAdd);
        result; // to remove annoying not used warning
        if (result > 0) {
          emit(TodoStateSuccess());
        } else {
          emit(TodoStateError());
        }
      },
    );
    on<TodoEventDelete>(
      (event, emit) async {
        int result = await TodoRepo().removeTodo(event.uuidToDelete);
        if (result > 0) {
          emit(TodoStateSuccess());
        } else {
          emit(TodoStateError());
        }
      },
    );
  }
}
