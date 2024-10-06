import 'package:flutter/material.dart';

class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  String nombreIntroducido = "";

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {
        if (nombreIntroducido == nombreIntroducido.isEmpty) {
          nombreIntroducido = "PEPE";
        }
        nombreIntroducido = _nameController.text;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'El nombre es obligatorio';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  String mensajeRespuesta = "Todo correcto!";
                  if (!_formKey.currentState!.validate()) {
                    mensajeRespuesta = "Algún campo no es válido";
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(mensajeRespuesta)),
                  );
                },
                child: const Text('GENERAR ROBOT'),
              ),
            ),
            Image(
              image:
                  NetworkImage("https://robohash.org/${_nameController.text}"),
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
