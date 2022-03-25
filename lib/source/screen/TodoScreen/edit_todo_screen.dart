import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_cubit/cubit/todo_cubit.dart';
import 'package:flutter_todo_cubit/data/Model/todoModel.dart';

class EditTodo extends StatefulWidget {
  final TodoModel todo;
  const EditTodo({Key? key, required this.todo}) : super(key: key);

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  TextEditingController controllerTodo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    controllerTodo.text = widget.todo.message;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Todo"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controllerTodo,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: "Masukan Task",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 45,
              child: ElevatedButton(
                  onPressed: () {
                    final todo = controllerTodo.text;
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  )),
                  child: Text('Edit Task')),
            ),
          )
        ],
      ),
    );
  }
}
