import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_copy/presentations/bloc/login/Login_block.dart';
import 'package:flutter_twitter_copy/presentations/bloc/login/Login_event.dart';

class EditProfileDialog extends StatefulWidget {
  @override
  _EditProfileDialogState createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _avatarUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    final username = loginBloc.state.username?.id ?? 'Cargando...';
    return AlertDialog(
      title: const Text('Modificar perfil'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _avatarUrlController,
              decoration: const InputDecoration(
                labelText: 'URL del avatar',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            BlocProvider.of<LoginBloc>(context).add(
              UpdateUserInfoEvent(
                userId: username,
                username: _nameController.text,
                avatar: _avatarUrlController.text,
              ),
            );
            Navigator.of(context).pop();
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
