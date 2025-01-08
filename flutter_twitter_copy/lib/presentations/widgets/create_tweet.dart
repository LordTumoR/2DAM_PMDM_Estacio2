import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_copy/domain/entities/tweet.dart';
import 'package:flutter_twitter_copy/presentations/bloc/Tweeter/TweerEvent.dart';
import 'package:flutter_twitter_copy/presentations/bloc/Tweeter/TweetBloc.dart';
import 'package:flutter_twitter_copy/presentations/bloc/login/Login_block.dart';

class CreateTweetScreen extends StatefulWidget {
  const CreateTweetScreen({Key? key}) : super(key: key);

  @override
  _CreateTweetScreenState createState() => _CreateTweetScreenState();
}

class _CreateTweetScreenState extends State<CreateTweetScreen> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Tweet'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Contenido del tweet',
              ),
            ),
            TextField(
              controller: _imageController,
              decoration: const InputDecoration(
                labelText: 'Imagen (URL opcional)',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createTweet,
              child: const Text('Crear Tweet'),
            ),
          ],
        ),
      ),
    );
  }

  void _createTweet() {
    final content2 = _contentController.text;
    final image =
        _imageController.text.isNotEmpty ? _imageController.text : null;

    final loginBloc = context.read<LoginBloc>();
    final username = loginBloc.state.username?.id ?? 'Cargando...';

    if (content2.isNotEmpty && username.isNotEmpty) {
      final tweet = Tweet(
        id: "",
        userId: username,
        content: content2,
        createdAt: DateTime.now(),
        likes: [],
        image: image,
      );

      context.read<TweetBloc>().add(CreateTweetEvent(
            userId: username,
            content: content2,
            image: image,
          ));

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Por favor, ingrese el contenido del tweet.')),
      );
    }
  }
}
