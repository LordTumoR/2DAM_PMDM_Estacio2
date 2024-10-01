import 'package:flutter/material.dart';
import 'package:fluttercontador/presentation/widgets/mi_texto_widget.dart';

class Secondscreen extends StatefulWidget {
  const Secondscreen({super.key});

  @override
  State<Secondscreen> createState() => _MyAppState();
}

class _MyAppState extends State<Secondscreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación Material',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('VEGETA ULTRA EGO'),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'lib/assets/background2.png',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
