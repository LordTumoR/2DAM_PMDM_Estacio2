import 'package:actividadlistaresenas/presentation/screens/productscreen.dart';
import 'package:actividadlistaresenas/presentation/screens/homescreen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        // Se debe usar 'pathParameters' en lugar de 'params'
        final productId = int.parse(state.pathParameters['id']!);
        return ProductScreen(productId: productId);
      },
    ),
  ],
);
