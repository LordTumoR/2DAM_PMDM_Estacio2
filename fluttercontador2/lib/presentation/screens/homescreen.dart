import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttercontador/config/router/routes.dart';
import 'package:fluttercontador/presentation/widgets/mi_texto_widget.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _MyAppState();
}

class _MyAppState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación Material',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Router APP'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  context.push('/firstscreen');
                },
                child: Image.asset(
                  'lib/assets/background3.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  context.push('/secondscreen');
                },
                child: Image.asset(
                  'lib/assets/background4.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
