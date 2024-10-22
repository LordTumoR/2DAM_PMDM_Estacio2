import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counterblock_cleanark/config/tema/apptheme.dart';
import 'package:flutter_counterblock_cleanark/domain/entities/character.dart';
import 'package:flutter_counterblock_cleanark/presentation/blocs/character_bloc.dart';
import 'package:flutter_counterblock_cleanark/presentation/blocs/character_event.dart';
import 'package:flutter_counterblock_cleanark/presentation/blocs/character_state.dart';
import 'package:flutter_counterblock_cleanark/presentation/blocs/theme/tema_bloc.dart';
import 'package:flutter_counterblock_cleanark/presentation/blocs/theme/tema_evento.dart';

class CharacterList extends StatelessWidget {
  final List<Character> characters;

  const CharacterList({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return ListTile(
          leading: Image.network(character.image),
          title: Text(character.name),
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Información de ${character.name}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('Fecha de nacimiento: ${character.dateOfBirth}'),
                      Text('Especie: ${character.species}'),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharactersScreen> {
  String _filter = '';

  @override
  void initState() {
    super.initState();
    context.read<CharacterBloc>().add(LoadCharactersEvent(_filter));
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text('Personajes de Harry Potter')),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _filter = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Filtrar por nombre',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    context
                        .read<CharacterBloc>()
                        .add(LoadCharactersEvent(_filter));
                  },
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<CharacterBloc, CharacterState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.errorMessage.isNotEmpty) {
                  return Center(child: Text(state.errorMessage));
                } else if (state.characters.isNotEmpty) {
                  return CharacterList(characters: state.characters);
                } else {
                  return const Center(
                      child: Text(
                          'No hay personajes que coincidan con el filtro.'));
                }
              },
            ),
          ),
        ],
      ),
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
