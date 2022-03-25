import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_cubit/cubit/todo_cubit.dart';
import 'package:flutter_todo_cubit/source/Router/string.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    //manggil cubit
    BlocProvider.of<TodoCubit>(context).getTodo();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ADD_TODO);
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is TodoLoaded == false) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          var todo = (state as TodoLoaded).todo;
          if (todo!.isEmpty) {
            return const Center(
              child: Text('Data Kosong'),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<TodoCubit>(context).refresh();
            },
            child: ListView.builder(
              itemCount: todo.length,
              itemBuilder: (BuildContext context, int index) {
                var data = todo[index];
                return Dismissible(
                  key: Key(data.id.toString()),
                  confirmDismiss: (_) async {
                    BlocProvider.of<TodoCubit>(context).updateTodo(data);
                    return false;
                  },
                  background: Container(color: Colors.indigo),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, EDIT_TODO, arguments: data);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0), boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 3,
                          spreadRadius: 3,
                          offset: const Offset(1, 3),
                        )
                      ]),
                      child: Row(
                        children: [
                          Text(data.message,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              )),
                          data.isCompleted.toString() == "1"
                              ? Icon(
                                  Icons.check_box_outlined,
                                  size: 20,
                                  color: Colors.green[800],
                                )
                              : Icon(
                                  Icons.close,
                                  size: 20,
                                  color: Colors.red[800],
                                )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
