import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_cubit/data/Model/todoModel.dart';
import 'package:flutter_todo_cubit/data/Network/network.dart';

class MyRepository {
  // akses internet
  final MyNetwork? myNetwork;

  MyRepository({this.myNetwork});

  Future<List<TodoModel>> fetchMyTodos() async {
    final json = await myNetwork!.fetchTodo();
    print("json $json");
    return json.map((e) => TodoModel.fromJson(e)).toList();
  }

  Future<dynamic> updateTodos(TodoModel data) async {
    final json = await myNetwork!.changeTodo(data);
    print("JSON update : $json");
    return json;
  }

  Future addTodo(String todo) async {
    final json = await myNetwork!.addTodo(todo);
    return json;
  }

  Future register(var name, var email, var password) async {
    var body = {
      "name": name,
      "email": email,
      "password": password,
    };
    final json = await myNetwork!.register(body);
    return json;
  }
}
