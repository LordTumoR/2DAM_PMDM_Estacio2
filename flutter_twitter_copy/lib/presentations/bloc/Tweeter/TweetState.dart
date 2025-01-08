import 'package:equatable/equatable.dart';
import 'package:flutter_twitter_copy/domain/entities/tweet.dart';

class TweetState extends Equatable {
  final bool isLoading;
  final List<Tweet> tweets;
  final String? errorMessage;

  const TweetState({
    required this.isLoading,
    required this.tweets,
    this.errorMessage,
  });

  factory TweetState.initial() {
    return const TweetState(
      isLoading: false,
      tweets: [],
      errorMessage: null,
    );
  }

  TweetState copyWith({
    bool? isLoading,
    List<Tweet>? tweets,
    String? errorMessage,
  }) {
    return TweetState(
      isLoading: isLoading ?? this.isLoading,
      tweets: tweets ?? this.tweets,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, tweets, errorMessage ?? ''];
}
