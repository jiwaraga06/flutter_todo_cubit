import 'dart:convert';
import 'package:flutter_todo_cubit/data/Model/todoModel.dart';
import 'package:flutter_todo_cubit/data/Network/api.dart';
import 'package:http/http.dart' as http;

class MyNetwork {
  Future<List<dynamic>> fetchTodo() async {
    try {
      var url = Uri.parse(Api.getTodo());
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['data'] as List;
      } else {
        return <dynamic>[];
      }
    } catch (e) {
      print('Error get todo: $e');
      return <dynamic>[];
    }
  }

  Future<dynamic> changeTodo(TodoModel data) async {
    try {
      var url = Uri.parse(Api.updateTodo());
      var response = await http.post(url, body: {
        "isCompleted": "1",
        "id": data.id.toString(),
      });
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future addTodo(String todo) async {
    try {
      var url = Uri.parse(Api.addTodo());
      var response = await http.post(url, body: {
        "message": todo,
      });
      final json = response;
      return json;
    } catch (e) {
      // return {};
    }
  }

  Future register(var body) async {
    try {
      var url = Uri.parse(Api.register());
      var response = await http.post(url, body: body);
      final json = response;
      return json;
    } catch (e) {}
  }

  Future login(body) async {
    try {
      var url = Uri.parse(Api.login());
      var response = await http.post(url, body: body);
      final json = response;
      return json;
    } catch (e) {}
  }
}
