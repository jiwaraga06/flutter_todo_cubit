import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_cubit/cubit/todo_cubit.dart';
import 'package:flutter_todo_cubit/data/Model/todoModel.dart';
import 'package:flutter_todo_cubit/data/Network/network.dart';
import 'package:flutter_todo_cubit/data/Repository/repository.dart';
import 'package:flutter_todo_cubit/source/Router/string.dart';
import 'package:flutter_todo_cubit/source/screen/Auth/login.dart';
import 'package:flutter_todo_cubit/source/screen/Auth/register.dart';
import 'package:flutter_todo_cubit/source/screen/TodoScreen/add_todo_screen.dart';
import 'package:flutter_todo_cubit/source/screen/TodoScreen/edit_todo_screen.dart';
import 'package:flutter_todo_cubit/source/screen/TodoScreen/todo_screen.dart';
import 'package:flutter_todo_cubit/source/screen/splash_screen.dart';

class RouterNavigation {
  MyRepository? myRepository;

  RouterNavigation() {
    myRepository = MyRepository(myNetwork: MyNetwork());
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => TodoCubit(
                    myRepository: myRepository,
                  ),
                  child: const SplashScreen(),
                ));
      case REGISTER:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => TodoCubit(
                    myRepository: myRepository,
                  ),
                  child: const Register(),
                ));
      case LOGIN:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TodoCubit(
              myRepository: myRepository,
            ),
            child: const Login(),
          ),
        );
      case HOME_TODO:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => TodoCubit(
                    myRepository: myRepository,
                  ),
                  child: const TodoScreen(),
                ));
      case ADD_TODO:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => TodoCubit(
                      myRepository: myRepository,
                    ),
                child: const AddTodo()));
      case EDIT_TODO:
        final todo = settings.arguments as TodoModel;
        return MaterialPageRoute(
            builder: (_) => EditTodo(
                  todo: todo,
                ));
      default:
        return null;
    }
  }
}
