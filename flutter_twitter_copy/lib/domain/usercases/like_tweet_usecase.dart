import 'package:dartz/dartz.dart';
import 'package:flutter_twitter_copy/domain/entities/user.dart';
import 'package:flutter_twitter_copy/domain/repositories/tweet_repository.dart';
import 'package:flutter_twitter_copy/domain/repositories/user_repository.dart';

class LikeTweetUseCase {
  final TweetRepository repository;

  LikeTweetUseCase(this.repository);

  Future<Either<String, void>> call(String userId, String tweetId) async {
    return await repository.likeTweet(userId, tweetId);
  }
}
