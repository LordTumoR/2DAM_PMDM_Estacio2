import 'package:flutter/material.dart';

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
          title: const Text(':('),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'lib/assets/buddy2.jpg',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
