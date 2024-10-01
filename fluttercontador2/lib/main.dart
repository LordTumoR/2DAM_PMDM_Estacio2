import 'package:flutter/material.dart';
import 'package:fluttercontador/config/router/routes.dart';
import 'package:fluttercontador/presentation/screens/homescreen.dart';

void main() {
  runApp(
    MaterialApp.router(
      routerConfig: router, // Configuración de `go_router`
    ),
  );
}
