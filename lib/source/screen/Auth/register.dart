import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_cubit/cubit/todo_cubit.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  var error = {};
  var validator = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: BlocListener<TodoCubit, TodoState>(
          listener: (context, state) {
            if (state is RegisterLoading) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                },
              );
            }
            if (state is RegisterLoaded) {
              Navigator.of(context).pop();
            }
            if (state is RegisterMessage) {
              CoolAlert.show(
                context: context,
                type: CoolAlertType.info,
                text: state.message,
              );
            }
            if (state is RegisterError) {
              setState(() {
                error = state.error;
                print("Error: ${error}");
              });
            }
          },
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controllerName,
                        decoration: InputDecoration(
                          hintText: 'Nama',
                        ),
                        autovalidateMode: error['name'] == null ? AutovalidateMode.disabled : AutovalidateMode.always,
                        validator: (_) {
                          if (error['name'] != null) {
                            return error['name'][0];
                          } else {
                            return '';
                          }
                        },
                      ),
                      TextFormField(
                        controller: controllerEmail,
                        decoration: InputDecoration(
                          hintText: 'Email',
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
                          hintText: 'Password',
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
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<TodoCubit>(context).register(controllerName.text, controllerEmail.text, controllerPassword.text);
                        },
                        child: Text('Register'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
