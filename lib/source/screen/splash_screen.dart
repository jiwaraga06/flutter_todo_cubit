import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_cubit/cubit/todo_cubit.dart';
import 'package:flutter_todo_cubit/source/Router/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodoCubit>(context).splashAUth();
    return Scaffold(
      body: BlocListener<TodoCubit, TodoState>(
        listener: (context, state) async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          var token = pref.getString('token');
          if (token != null) {
            Navigator.pushReplacementNamed(context, HOME_TODO);
          } else {
            Navigator.pushReplacementNamed(context, LOGIN);
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Splash Screen'),
              CupertinoActivityIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
