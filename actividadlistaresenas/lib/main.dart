import 'package:flutter/material.dart';
import 'config/router/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Listado de Productos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
