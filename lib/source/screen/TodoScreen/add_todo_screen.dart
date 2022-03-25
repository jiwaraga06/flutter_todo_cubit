import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_cubit/cubit/todo_cubit.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController controllerTodo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: BlocListener<TodoCubit, TodoState>(
        listener: (context, state) {
          if (state is TodoAddLoaded) {
            Navigator.pop(context);
            return;
          }
        },
        child: ListView(
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
                    BlocProvider.of<TodoCubit>(context).addTodo(todo);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  )),
                  child: BlocBuilder<TodoCubit, TodoState>(
                    builder: (context, state) {
                      if (state is TodoAddLoading) return CupertinoActivityIndicator();
                      return Text('Tambah Task');
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
