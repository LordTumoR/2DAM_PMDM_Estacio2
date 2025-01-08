import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_copy/domain/entities/tweet.dart';
import 'package:flutter_twitter_copy/presentations/bloc/Tweeter/TweerEvent.dart';
import 'package:flutter_twitter_copy/presentations/bloc/Tweeter/TweetBloc.dart';
import 'package:flutter_twitter_copy/presentations/bloc/login/Login_block.dart';

class TweetCard extends StatelessWidget {
  final Tweet tweet;

  const TweetCard({Key? key, required this.tweet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginBloc>().state;
    final username = state.username?.id ?? 'Cargando...';

    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                tweet.userAvatar ?? 'https://via.placeholder.com/150',
              ),
            ),
            title: Row(
              children: [
                Text(
                  tweet.userId,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.check_circle, size: 16, color: Colors.blue),
              ],
            ),
          ),
          if (tweet.image != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                tweet.image!,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              tweet.content,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Builder(
                        builder: (context) {
                          final userId =
                              context.read<LoginBloc>().state.username?.id;
                          IconData iconData;
                          Color iconColor;

                          if (tweet.likes.contains(userId)) {
                            iconData = Icons.thumb_up;
                            iconColor = Colors.blue;
                          } else {
                            iconData = Icons.thumb_up_alt_outlined;
                            iconColor = Colors.grey;
                          }

                          return Icon(iconData, color: iconColor);
                        },
                      ),
                      onPressed: () {
                        final userId =
                            context.read<LoginBloc>().state.username?.id;
                        if (userId != null) {
                          context.read<TweetBloc>().add(LikeTweetEvent(
                              tweetId: tweet.id, userId: userId));
                        } else {
                          print("user id es null");
                        }
                      },
                    ),
                    Text(tweet.likes.length.toString()),
                  ],
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
