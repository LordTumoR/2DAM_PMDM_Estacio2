import 'package:dartz/dartz.dart';
import 'package:flutter_twitter_copy/domain/entities/tweet.dart';
import 'package:flutter_twitter_copy/domain/repositories/tweet_repository.dart';

class GetFollowUsersTweetsUseCase {
  final TweetRepository repository;

  GetFollowUsersTweetsUseCase(this.repository);

  Future<Either<String, List<Tweet>>> call(String userId) async {
    return await repository.getFollowUsersTweets(userId);
  }
}
