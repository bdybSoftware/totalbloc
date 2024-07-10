part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

final class TodoStateInitial extends TodoState {}

class TodoStateFetchLoading extends TodoState {}

class TodoStateLoaded extends TodoState {
  final List<Todo> fetchedTodos;
  const TodoStateLoaded({required this.fetchedTodos});

  @override
  List<Object> get props => [fetchedTodos];
}

abstract class TodoStateAction extends TodoState {}

class TodoStateError extends TodoStateAction {}

class TodoStateSuccess extends TodoStateAction {}
