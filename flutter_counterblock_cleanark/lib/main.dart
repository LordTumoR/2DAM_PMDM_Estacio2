import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counterblock_cleanark/config/router/routes.dart';
import 'package:flutter_counterblock_cleanark/presentation/blocs/character_bloc.dart';
import 'package:flutter_counterblock_cleanark/presentation/blocs/theme/tema_bloc.dart';
import 'package:flutter_counterblock_cleanark/presentation/blocs/theme/tema_state.dart';
import 'injection_container.dart' as injection_container;

void main() async {
  await injection_container.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => injection_container.sl<CharacterBloc>()),
        BlocProvider(create: (context) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            theme: state.appTheme.getTheme(),
          );
        },
      ),
    );
  }
}
