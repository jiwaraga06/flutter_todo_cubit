import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_cubit/cubit/todo_cubit.dart';
import 'package:flutter_todo_cubit/source/Router/string.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  var error = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocListener<TodoCubit, TodoState>(
        listener: (context, state) {
          if (state is LoginError) {
            setState(() {
              error = state.error;
            });
          }
        },
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: controllerEmail,
                    decoration: InputDecoration(
                      hintText: 'Masukan Email',
                    ),
                    autovalidateMode: error['email'] == null ? AutovalidateMode.disabled : AutovalidateMode.always,
                        validator: (_) {
                          if (error['email'] != null) {
                            return error['email'][0];
                          } else {
                            return '';
                          }
                        },
                  ),
                  TextFormField(
                    controller: controllerPassword,
                    decoration: InputDecoration(
                      hintText: 'Masukan Password',
                    ),
                    autovalidateMode: error['password'] == null ? AutovalidateMode.disabled : AutovalidateMode.always,
                        validator: (_) {
                          if (error['password'] != null) {
                            return error['password'][0];
                          } else {
                            return '';
                          }
                        },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, REGISTER);
                },
                child: Text('Register'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<TodoCubit>(context).login(controllerEmail.text, controllerPassword.text);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[700],
                ),
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
