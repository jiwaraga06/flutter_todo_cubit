import 'package:flutter/material.dart';
import 'package:flutter_todo_cubit/source/Router/router.dart';
import 'package:flutter_todo_cubit/source/Router/string.dart';

void main() {
  runApp(MyApp(
    router: RouterNavigation(),
  ));
}

class MyApp extends StatelessWidget {
  final RouterNavigation? router;

  const MyApp({Key? key, this.router}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Cubit',
      debugShowCheckedModeBanner: false,
      //hapus bagian home diganti dengan onGenerateRoute
      // nanti akan menjalankan fungsi generateRoute yang ada di RouterNavigation
      // untuk pindah halaman
      onGenerateRoute: router!.generateRoute,
    );
  }
}
