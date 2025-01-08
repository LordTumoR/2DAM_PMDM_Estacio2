import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_copy/domain/usercases/create_tweet_usecase.dart';
import 'package:flutter_twitter_copy/domain/usercases/delete_tweet_usecase.dart';
import 'package:flutter_twitter_copy/domain/usercases/get_tweet_usercase.dart';
import 'package:flutter_twitter_copy/domain/usercases/like_tweet_usecase.dart';
import 'package:flutter_twitter_copy/domain/usercases/update_tweet_usecase.dart';
import 'package:flutter_twitter_copy/domain/usercases/get_followers_usercase.dart';
import 'package:flutter_twitter_copy/presentations/bloc/Tweeter/TweetState.dart';
import 'package:flutter_twitter_copy/presentations/bloc/Tweeter/TweerEvent.dart';
import 'package:flutter_twitter_copy/domain/entities/tweet.dart';

class TweetBloc extends Bloc<TweetEvent, TweetState> {
  final GetTweetsUseCase getTweetsUseCase;
  final CreateTweetUseCase createTweetUseCase;
  final DeleteTweetUseCase deleteTweetUseCase;
  final LikeTweetUseCase likeTweetUseCase;
  final UpdateTweetUseCase updateTweetUseCase;
  final GetFollowUsersTweetsUseCase getFollowUsersTweetUseCase;

  TweetBloc({
    required this.getTweetsUseCase,
    required this.createTweetUseCase,
    required this.deleteTweetUseCase,
    required this.likeTweetUseCase,
    required this.updateTweetUseCase,
    required this.getFollowUsersTweetUseCase,
  }) : super(TweetState.initial()) {
    on<GetTweetsEvent>(_getTweets);
    on<CreateTweetEvent>(_createTweet);
    on<DeleteTweetEvent>(_deleteTweet);
    on<UpdateTweetEvent>(_updateTweet);
    on<LikeTweetEvent>(_likeTweet);
  }

  Future<void> _getTweets(
    GetTweetsEvent event,
    Emitter<TweetState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await getTweetsUseCase();

    result.fold(
      (error) => emit(state.copyWith(isLoading: false, errorMessage: error)),
      (tweets) => emit(state.copyWith(isLoading: false, tweets: tweets)),
    );
  }

  Future<void> _createTweet(
    CreateTweetEvent event,
    Emitter<TweetState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result =
        await createTweetUseCase(event.userId, event.content, event.image);

    result.fold(
      (error) => emit(state.copyWith(isLoading: false, errorMessage: error)),
      (_) {
        final newTweet = Tweet(
          id: "",
          userId: event.userId,
          content: event.content,
          createdAt: DateTime.now(),
          likes: [],
          image: event.image,
        );
        final updatedTweets = List<Tweet>.from(state.tweets)..add(newTweet);
        emit(state.copyWith(isLoading: false, tweets: updatedTweets));
      },
    );
  }

  Future<void> _deleteTweet(
    DeleteTweetEvent event,
    Emitter<TweetState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await deleteTweetUseCase(event.tweetId);

    result.fold(
      (error) => emit(state.copyWith(isLoading: false, errorMessage: error)),
      (_) {
        final updatedTweets =
            state.tweets.where((tweet) => tweet.id != event.tweetId).toList();
        emit(state.copyWith(isLoading: false, tweets: updatedTweets));
      },
    );
  }

  Future<void> _updateTweet(
    UpdateTweetEvent event,
    Emitter<TweetState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result =
        await updateTweetUseCase(event.tweetId, event.content, event.image);

    result.fold(
      (error) => emit(state.copyWith(isLoading: false, errorMessage: error)),
      (_) {
        final updatedTweets = state.tweets.map((tweet) {
          if (tweet.id == event.tweetId) {
            return Tweet(
              id: tweet.id,
              userId: tweet.userId,
              content: event.content ?? "",
              createdAt: tweet.createdAt,
              likes: tweet.likes,
              image: event.image ?? tweet.image,
            );
          }
          return tweet;
        }).toList();
        emit(state.copyWith(isLoading: false, tweets: updatedTweets));
      },
    );
  }

  Future<void> _likeTweet(
    LikeTweetEvent event,
    Emitter<TweetState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await likeTweetUseCase(event.tweetId, event.userId);

    result.fold(
      (error) => emit(state.copyWith(isLoading: false, errorMessage: error)),
      (_) {
        final updatedTweets = state.tweets.map((tweet) {
          if (tweet.id == event.tweetId) {
            List<String> updatedLikes = List<String>.from(tweet.likes);
            if (!updatedLikes.contains(event.userId)) {
              updatedLikes.add(event.userId);
            }
            return Tweet(
              id: tweet.id,
              userId: tweet.userId,
              content: tweet.content,
              createdAt: tweet.createdAt,
              likes: updatedLikes,
              image: tweet.image,
            );
          }
          return tweet;
        }).toList();
        emit(state.copyWith(isLoading: false, tweets: updatedTweets));
      },
    );
  }
}
