import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_cubit/data/Model/todoModel.dart';
import 'package:flutter_todo_cubit/data/Repository/repository.dart';
import 'package:flutter_todo_cubit/source/Router/string.dart';
import 'package:meta/meta.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final MyRepository? myRepository;

  TodoCubit({this.myRepository}) : super(TodoInitial());

  void getTodo() {
    Timer(const Duration(seconds: 2), () {
      myRepository!.fetchMyTodos().then((todo) {
        emit(TodoLoaded(todo: todo));
      });
    });
  }

  void updateTodo(TodoModel data) {
    myRepository!.updateTodos(data).then((value) {
      print(value);
      if (value) {
        updateTodoList(value);
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
        print("value Add Todo :$value");
        // addTodos(value['todo'][0]);
        emit(TodoAddLoaded());
      });
    });
  }

  void addTodos(TodoModel todo) {
    final currentState = state;
    if (currentState is TodoLoaded) {
      final todoList = currentState.todo;
      print("Add Todos:   $todoList");
      emit(TodoLoaded(todo: todoList));
    }
  }

  void refresh() {
    emit(TodoLoading());
    Future.delayed(const Duration(seconds: 2));
    myRepository!.fetchMyTodos().then((todo) {
      emit(TodoLoaded(todo: todo));
    });
  }

  Future splashAUth() async {
    emit(SplashLoading());
    var a = false;
    await Future.delayed(const Duration(seconds: 2));
    emit(SplashLoaded());
    if (a == true) {
      emit(SplashValue(auth: true));
    } else {
      emit(SplashValue(auth: false));
    }
  }

  Future register(name, email, password) async{
    emit(RegisterLoading());
    await Future.delayed(const Duration(seconds: 2));
    myRepository!.register(name, email, password).then((value) {
      print('Value register: $value');
      emit(RegisterMessage(message: value['message']));
      emit(RegisterError(error: value['error']));
    });
      emit(RegisterLoaded());
  }
}