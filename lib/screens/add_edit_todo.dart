import 'package:flutter/material.dart';
import 'package:totalbloc/models/todo.dart';
import 'package:totalbloc/features/Todo/bloc/todo_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditTodo extends StatefulWidget {
  final Todo? editTodo;
  const AddEditTodo({this.editTodo, super.key});

  @override
  State<AddEditTodo> createState() => _AddEditTodoState();
}

class _AddEditTodoState extends State<AddEditTodo> {
  final todoName = TextEditingController();
  final todoDescription = TextEditingController();
  bool todoFavorite = false;

  void fillTexts() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        todoName.text = widget.editTodo!.todoName;
        todoDescription.text = widget.editTodo!.todoDescription;
        todoFavorite = widget.editTodo!.todoFav;
      });
    });
  }

  @override
  void initState() {
    // if not editTodo was supplied have an empty on
    widget.editTodo ?? Todo(todoName: "", todoDescription: "", todoFav: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                flex: 1,
                child: Text("Name"),
              ),
              Expanded(
                  flex: 2,
                  child: TextField(
                    controller: todoName,
                  )),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                flex: 1,
                child: Text("Description"),
              ),
              Expanded(
                  flex: 2,
                  child: TextField(
                    controller: todoDescription,
                  )),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                flex: 1,
                child: Text("Favorite"),
              ),
              Expanded(
                flex: 2,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      todoFavorite = !todoFavorite;
                      print("todoFavorite: $todoFavorite");
                    });
                  },
                  icon: todoFavorite
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border_outlined,
                        ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          Center(
            child: TextButton(
                onPressed: () {
                  Todo todoToAdd = Todo(
                      todoName: todoName.text,
                      todoDescription: todoDescription.text,
                      todoFav: todoFavorite);
                  context
                      .read<TodoBloc>()
                      .add(TodoEventAdd(todoToAdd: todoToAdd));
                },
                child: const Text("Save/Add")),
          ),
        ],
      ),
    );
  }
}
