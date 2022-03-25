import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_cubit/cubit/todo_cubit.dart';
import 'package:flutter_todo_cubit/source/Router/string.dart';

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
        listener: (context, state) {
          if (state is SplashLoaded) {
            if (state is SplashValue == true) {
              Navigator.pushReplacementNamed(context, HOME_TODO);
            } else {
              Navigator.pushReplacementNamed(context, REGISTER);
            }
          }
        },
        child: Center(
          child: Text('Splash Screen'),
        ),
      ),
    );
  }
}
