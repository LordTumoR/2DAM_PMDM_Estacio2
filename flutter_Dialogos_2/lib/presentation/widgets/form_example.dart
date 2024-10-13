import 'package:flutter/material.dart';
import '../../infraestructure/models/usuario.dart';

class FormularioRegistro extends StatefulWidget {
  const FormularioRegistro({super.key});

  @override
  State<FormularioRegistro> createState() => _FormularioRegistroState();
}

class _FormularioRegistroState extends State<FormularioRegistro> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();

  String _sexo = '';
  final List<String> _aficiones = [];

  // Aficions
  final List<String> aficionesDisponibles = [
    'Deportes',
    'Lectura',
    'Cocinar',
    'Videojuegos',
    'Viajar'
  ];

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidosController.dispose();
    _edadController.dispose();
    _correoController.dispose();
    super.dispose();
  }

  Usuario? _registrarUsuario() {
    if (_formKey.currentState!.validate() && _aficiones.isNotEmpty) {
      // La instancia:
      final usuario = Usuario(
        nombre: _nombreController.text,
        apellidos: _apellidosController.text,
        edad: int.parse(_edadController.text),
        correo: _correoController.text,
        sexo: _sexo,
        aficiones: _aficiones,
      );

      return usuario;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Por favor, completa el formulario correctamente')),
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // si el dialeg es mol gran aço fa que no sen ixa del "rango".
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // NOM
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // COGNOMS:
              TextFormField(
                controller: _apellidosController,
                decoration: const InputDecoration(labelText: 'Apellidos'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Los apellidos son obligatorios';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // EDAt
              TextFormField(
                controller: _edadController,
                decoration: const InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La edad es obligatoria';
                  }
                  final edad = int.tryParse(value);
                  if (edad == null || edad < 18) {
                    return 'Debe ser mayor de 18 años';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Correo
              TextFormField(
                controller: _correoController,
                decoration: const InputDecoration(labelText: 'Correo'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El correo es obligatorio';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Introduce un correo válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Sexe boto radio
              const Text('Sexo'),
              Row(
                children: [
                  Radio<String>(
                    value: 'Masculino',
                    groupValue: _sexo,
                    onChanged: (value) {
                      setState(() {
                        _sexo = value!;
                      });
                    },
                  ),
                  const Text('Masculino'),
                  Radio<String>(
                    value: 'Femenino',
                    groupValue: _sexo,
                    onChanged: (value) {
                      setState(() {
                        _sexo = value!;
                      });
                    },
                  ),
                  const Text('Femenino'),
                ],
              ),

              // Aficcions
              const Text('Aficiones'),
              ...aficionesDisponibles.map((aficion) {
                //creen la checkbox
                return CheckboxListTile(
                  title: Text(aficion),
                  value: _aficiones.contains(aficion),
                  onChanged: (bool? value) {
                    //per a que se añadixca una aficio
                    setState(() {
                      if (value == true) {
                        _aficiones.add(aficion);
                      } else {
                        _aficiones.remove(aficion);
                      }
                    });
                  },
                );
              }),
              const SizedBox(height: 20),

              // Boto pa registrarse
              ElevatedButton(
                onPressed: () {
                  final usuario = _registrarUsuario();
                  if (usuario != null) {
                    Navigator.of(context).pop(usuario); // Tornem el objecte
                  }
                },
                child: const Text('Aceptar'),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(null); // Tornem null si es cancel·la
                },
                child: const Text('Cancelar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
