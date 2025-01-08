import 'package:equatable/equatable.dart';

abstract class TweetEvent extends Equatable {
  const TweetEvent();

  @override
  List<Object> get props => [];
}

class GetTweetsEvent extends TweetEvent {}

class CreateTweetEvent extends TweetEvent {
  final String userId;
  final String content;
  final String? image;

  const CreateTweetEvent({
    required this.userId,
    required this.content,
    this.image,
  });

  @override
  List<Object> get props => [userId, content, image ?? ''];
}

class DeleteTweetEvent extends TweetEvent {
  final String tweetId;

  const DeleteTweetEvent({required this.tweetId});

  @override
  List<Object> get props => [tweetId];
}

class UpdateTweetEvent extends TweetEvent {
  final String tweetId;
  final String? content;
  final String? image;

  const UpdateTweetEvent({
    required this.tweetId,
    this.content,
    this.image,
  });

  @override
  List<Object> get props => [tweetId, content ?? '', image ?? ''];
}

class LikeTweetEvent extends TweetEvent {
  final String tweetId;
  final String userId;

  const LikeTweetEvent({required this.tweetId, required this.userId});

  @override
  List<Object> get props => [tweetId, userId];
}
