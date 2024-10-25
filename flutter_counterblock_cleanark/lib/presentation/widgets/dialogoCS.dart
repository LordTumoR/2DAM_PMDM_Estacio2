// dialogo_confirmacion.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_counterblock_cleanark/presentation/blocs/login/login_block.dart';
import 'package:flutter_counterblock_cleanark/presentation/blocs/login/login_event.dart';

Future<void> mostrarDialogoDeConfirmacion(BuildContext mainContext) {
  return showDialog(
    context: mainContext,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text("Confirmación"),
        content: const Text("¿Seguro que quieres salir?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              mainContext.read<LoginBloc>().add(LogoutButtonPressed());
              mainContext.go('/login');
            },
            child: const Text("Confirmar"),
          ),
        ],
      );
    },
  );
}
