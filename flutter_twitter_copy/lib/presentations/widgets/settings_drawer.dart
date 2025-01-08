import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_copy/presentations/bloc/login/Login_block.dart';
import 'package:flutter_twitter_copy/presentations/bloc/login/Login_event.dart';
import 'package:flutter_twitter_copy/presentations/bloc/login/login_state.dart';
import 'package:flutter_twitter_copy/presentations/widgets/edit_user.dart';
import 'package:go_router/go_router.dart'; // Importar GoRouter

class SettingsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.username == null) {
          context.go('/login');
        }
      },
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                final username = state.username?.username ?? 'Cargando...';
                final avatarUrl = state.username?.avatar;

                if (username == 'Cargando...') {
                  return const DrawerHeader(
                    decoration: BoxDecoration(color: Colors.grey),
                    child: Center(
                      child: Text(
                        'Usuario no encontrado',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  );
                } else {
                  return DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: avatarUrl != null
                              ? NetworkImage(avatarUrl)
                              : AssetImage('assets/default_avatar.png')
                                  as ImageProvider,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Bienvenido $username',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Modificar perfil'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return EditProfileDialog();
                  },
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {
                context.read<LoginBloc>().add(LogoutButtonPressed());
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
