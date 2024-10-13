import 'package:flutter/material.dart';
import 'package:flutter_ejemplo_form/presentation/widgets/widgets.dart';
import 'infraestructure/models/usuario.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro Usuario',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  Future<void> _mostrarDialogoFormulario(BuildContext context) async {
    final resultado = await showDialog<Usuario>(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Formulario de Registro'),
          content: FormularioRegistro(),
        );
      },
    );

    // Si hi ha resultat (un usuari registrat), el mostrem en un altre AlertDialog
    if (resultado != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Usuario Registrado'),
            content: Text(
              'Nombre: ${resultado.nombre}\n'
              'Apellidos: ${resultado.apellidos}\n'
              'Edad: ${resultado.edad}\n'
              'Correo: ${resultado.correo}\n'
              'Sexo: ${resultado.sexo}\n'
              'Aficiones: ${resultado.aficiones.join(', ')}',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Cas de cancelació
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text('Registro Cancelado'),
            content: Text('No se registró ningún usuario.'),
            actions: [
              TextButton(
                onPressed: null, // Tanca el diàleg
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Usuario'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _mostrarDialogoFormulario(context),
          child: const Text('Registrar Usuario'),
        ),
      ),
    );
  }
}
