import 'package:flutter/material.dart';
import 'package:totalbloc/models/todo.dart';
import 'package:totalbloc/features/Todo/bloc/todo_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final todoBloc = TodoBloc();
  @override
  void initState() {
    todoBloc.add(TodoEventLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: BlocConsumer<TodoBloc, TodoState>(
          bloc: todoBloc,
          // buildWhen: (previous, current) => current is TodoStateAction,
          // listenWhen: (previous, current) => current is! TodoStateAction,
          listener: (context, state) {},
          builder: (context, state) {
            print("todo_list_screen.dart, state is ${state.runtimeType}");
            switch (state.runtimeType) {
              case TodoStateFetchLoading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case const (TodoStateLoaded):
                final items = state as TodoStateLoaded;
                print("todo_list_screen.dart, TodoStateLoaded");

                return items.fetchedTodos.isNotEmpty
                    ? Center(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: items.fetchedTodos.length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(items.fetchedTodos[index].todoName),
                                      Text(items
                                          .fetchedTodos[index].todoDescription),
                                      items.fetchedTodos[index].todoFav
                                          ? const Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            )
                                          : const Icon(
                                              Icons.favorite_border_outlined)
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        context.read<TodoBloc>().add(
                                            TodoEventDelete(
                                                uuidToDelete: items
                                                    .fetchedTodos[index]
                                                    .todoUuid));
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ))
                                ],
                              );
                            }),
                      )
                    : Container(
                        color: Colors.red,
                        width: 50,
                        height: 50,
                      );
              default:
                print("todo_list_screen.dart, 2 state is ${state.runtimeType}");
                return Container(
                  color: Colors.blueAccent,
                  width: 50,
                  height: 50,
                );
            }
          }),
    );
  }
}
