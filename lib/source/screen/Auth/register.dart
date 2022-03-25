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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: controllerName,
                    decoration: InputDecoration(
                      hintText: 'Nama',
                    ),
                  ),
                  TextFormField(
                    controller: controllerEmail,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                    autovalidateMode: AutovalidateMode.always,
                    validator: (_) {},
                  ),
                  TextFormField(
                    controller: controllerPassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<TodoCubit>(context).register(controllerName.text, controllerEmail.text, controllerPassword.text);
                    },
                    child: Text('Register'),
                  ),
                  BlocBuilder<TodoCubit, TodoState>(
                    builder: (context, state) {
                      if (state is RegisterMessage) {
                        var msg = (state as RegisterMessage).message;
                        return Text(msg);
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
