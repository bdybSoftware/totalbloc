import 'package:flutter/material.dart';
import 'package:totalbloc/screens/add_edit_todo.dart';
import 'package:totalbloc/screens/todo_list_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("TotalBloc"),
        ),
        resizeToAvoidBottomInset: false,
        body: const Column(
          children: [
            Flexible(
              fit: FlexFit.loose,
              flex: 1,
              child: AddEditTodo(),
            ),
            Flexible(
              fit: FlexFit.loose,
              flex: 2,
              child: TodoListScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
