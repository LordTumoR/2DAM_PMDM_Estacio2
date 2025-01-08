import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_copy/presentations/bloc/Tweeter/TweerEvent.dart';
import 'package:flutter_twitter_copy/presentations/bloc/Tweeter/TweetBloc.dart';
import 'package:flutter_twitter_copy/presentations/bloc/Tweeter/TweetState.dart';
import 'package:flutter_twitter_copy/presentations/bloc/login/Login_block.dart';
import 'package:flutter_twitter_copy/presentations/bloc/login/Login_event.dart';
import 'package:flutter_twitter_copy/presentations/bloc/login/login_state.dart';
import 'package:flutter_twitter_copy/presentations/widgets/create_tweet.dart';
import 'package:flutter_twitter_copy/presentations/widgets/settings_drawer.dart';
import 'package:flutter_twitter_copy/presentations/widgets/tweet_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TweetBloc>().add(GetTweetsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          '🐦Twitter 🐦',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      endDrawer: SettingsDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar usuarios...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                context.read<LoginBloc>().add(GetUsersEvent(query: value));
              },
            ),
          ),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const LinearProgressIndicator();
              } else if (state.errorMessage.isNotEmpty) {
                return Center(child: Text('Error: ${state.errorMessage}'));
              } else if (state.searchedUsers.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.searchedUsers.length,
                    itemBuilder: (context, index) {
                      final user = state.searchedUsers[index];
                      return ListTile(
                        title: Text(user.username),
                        onTap: () {
                          _searchController.text = user.username;
                          FocusScope.of(context).unfocus();
                        },
                      );
                    },
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          Expanded(
            child: BlocBuilder<TweetBloc, TweetState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.errorMessage != null &&
                    state.errorMessage!.isNotEmpty) {
                  return Center(child: Text('Error: ${state.errorMessage}'));
                } else if (state.tweets.isEmpty) {
                  return const Center(child: Text('No tweets available.'));
                } else {
                  return ListView.builder(
                    itemCount: state.tweets.length,
                    itemBuilder: (context, index) {
                      final tweet = state.tweets[index];
                      return TweetCard(tweet: tweet);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCreateTweet(context),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToCreateTweet(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateTweetScreen(),
      ),
    );
  }
}
