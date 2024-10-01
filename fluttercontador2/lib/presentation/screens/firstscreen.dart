import 'package:flutter/material.dart';
import 'package:fluttercontador/presentation/widgets/mi_texto_widget.dart';

class Firstscreen extends StatefulWidget {
  const Firstscreen({super.key});

  @override
  State<Firstscreen> createState() => _MyAppState();
}

class _MyAppState extends State<Firstscreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación Material',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GOKU UI'),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'lib/assets/background.png',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
