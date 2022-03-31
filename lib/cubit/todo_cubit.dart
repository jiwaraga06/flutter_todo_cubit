import 'dart:async';
import 'dart:convert';
import 'dart:js';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_cubit/data/Model/todoModel.dart';
import 'package:flutter_todo_cubit/data/Repository/repository.dart';
import 'package:flutter_todo_cubit/source/Router/string.dart';
import 'package:flutter_todo_cubit/source/screen/TodoScreen/todo_screen.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final MyRepository? myRepository;

  TodoCubit({this.myRepository}) : super(TodoInitial());

  void getTodo() {
    myRepository!.fetchMyTodos().then((todo) {
      emit(TodoLoaded(todo: todo));
    });
  }

  void updateTodo(TodoModel data) {
    myRepository!.updateTodos(data).then((value) {
      print(value);
      if (value) {
        getTodo();
      }
    });
  }

  void updateTodoList(TodoModel todo) {
    final currentState = state;
    if (currentState is TodoLoaded) {
      emit(TodoLoaded(todo: currentState.todo));
    }
  }

  void addTodo(String todo) {
    if (todo.isEmpty) {
      emit(TodoAddError(errorMessage: "Task masih kosong"));
      return;
    }
    emit(TodoAddLoading());
    Timer(const Duration(seconds: 2), () {
      myRepository!.addTodo(todo).then((value) {
        var json = jsonDecode(value.body);
        print("value Add Todo :$json");
        // addTodos(value['todo'][0]);
        emit(TodoAddLoaded());
      });
    });
  }

  void addTodos(TodoModel todo) {
    final currentState = state;
    if (currentState is TodoLoaded) {
      final todoList = currentState.todo;
      print("Add Todos: $todoList");
      emit(TodoLoaded(todo: todoList));
    }
  }

  Future refresh() async {
    // emit(TodoLoading());
    await Future.delayed(const Duration(seconds: 2));
    myRepository!.fetchMyTodos().then((todo) {
      emit(TodoLoaded(todo: todo));
    });
  }

  Future splashAUth() async {
    emit(SplashLoading());

    await Future.delayed(const Duration(seconds: 2));
    emit(SplashLoaded());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var a = pref.getString('token');
    // if (a!.isNotEmpty) {
    //   emit(SplashValue(auth: true));
    // } else {
    //   emit(SplashValue(auth: false));
    // }
  }

  void register(name, email, password) async {
    emit(RegisterLoading());
    myRepository!.register(name, email, password).then((value) {
      var json = jsonDecode(value.body);
      print('Value register: $json');
      print('Value status: ${value.statusCode.toString()}');
      if (value.statusCode == 200) {
        emit(RegisterLoaded());
        emit(RegisterMessage(message: json['message']));
      } else {
        emit(RegisterLoaded());
        emit(RegisterMessage(message: json['message']));
        emit(RegisterError(error: json['error']));
        // print(json['error'].toString());
      }
    });
  }

  void login(email, password) {
    emit(LoginLoading());
    myRepository!.login(email, password).then((value) async {
      var json = jsonDecode(value.body);
      print('LOGIN :$json');
      if (value.statusCode == 200) {
        emit(LoginLoaded());
        emit(LoginMessage(message: json['message']));
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('token', json['access_token']);
        emit(AuthToken(auth: json['access_token']));
      } else {
        emit(LoginLoaded());
        emit(LoginMessage(message: json['message']));
        emit(LoginError(error: json['error']));
      }
    });
  }
}
