import 'package:fluttercontador/presentation/screens/firstscreen.dart';
import 'package:fluttercontador/presentation/screens/homescreen.dart';
import 'package:fluttercontador/presentation/screens/secondscreen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: 'home',
      path: '/', // Ruta raíz o Home
      builder: (context, state) => const Homescreen(),
    ),
    GoRoute(
      name: 'firstscreen',
      path: '/firstscreen', // Ruta raíz o Home
      builder: (context, state) => const Firstscreen(),
    ),
    GoRoute(
      name: 'secondscreen',
      path: '/secondscreen', // Ruta raíz o Home
      builder: (context, state) => const Secondscreen(),
    ),
  ],
);
