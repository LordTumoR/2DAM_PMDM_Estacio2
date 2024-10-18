import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/config/tema/apptheme.dart';
import 'package:flutter_counter_bloc/presentation/blocs/counter/counter_bloc.dart';
import 'package:flutter_counter_bloc/presentation/blocs/counter/counter_event.dart';
import 'package:flutter_counter_bloc/presentation/blocs/counter/counter_state.dart';
import 'package:flutter_counter_bloc/presentation/blocs/theme/tema_bloc.dart';
import 'package:flutter_counter_bloc/presentation/blocs/theme/tema_evento.dart';
import 'package:flutter_counter_bloc/presentation/widgets/counter_buttons_widget.dart';

class CounterHomePageScreen extends StatelessWidget {
  const CounterHomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    final themeBloc = BlocProvider.of<ThemeBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return Text('Total Transacciones ${state.transactionCount}');
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.refresh),
              title: const Text('Resetear contador'),
              onTap: () {
                context.read<CounterBloc>().add(CounterReset());
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: const Text('Cambiar color del tema'),
              onTap: () {
                _showColorDialog(context, themeBloc);
              },
            ),
            ListTile(
              leading: const Icon(Icons.nightlight_round),
              title: const Text('Activar blanco/oscuro'),
              trailing: Switch(
                value: themeBloc.state.appTheme.isDarkmode,
                onChanged: (bool value) {
                  themeBloc.add(ThemeChange(
                    isDarkMode: value,
                    selectedColor: themeBloc.state.appTheme.selectedColor,
                  ));
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child:
            BlocBuilder<CounterBloc, CounterState>(builder: (context, state) {
          return Text('Cuenta: ${state.counter}');
        }),
      ),
      floatingActionButton: const CounterButtonsWidget(),
    );
  }

  void _showColorDialog(BuildContext context, ThemeBloc themeBloc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecciona un color'),
          content: SingleChildScrollView(
            child: Column(
              children: colorList.asMap().entries.map((entry) {
                final int index = entry.key;
                final Color color = entry.value;

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: color,
                  ),
                  title: Text('Color ${index + 1}'),
                  onTap: () {
                    themeBloc.add(ThemeChange(
                      isDarkMode: themeBloc.state.appTheme.isDarkmode,
                      selectedColor: index,
                    ));
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
