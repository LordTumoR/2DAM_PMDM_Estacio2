import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/presentation/blocs/theme/tema_bloc.dart';
import 'package:flutter_counter_bloc/presentation/blocs/theme/tema_state.dart';
import 'package:flutter_counter_bloc/presentation/screens/counter_home_page_screen.dart';
import 'presentation/blocs/counter/counter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CounterBloc()),
        BlocProvider(create: (context) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.appTheme.getTheme(),
            home: const CounterHomePageScreen(),
          );
        },
      ),
    );
  }
}
