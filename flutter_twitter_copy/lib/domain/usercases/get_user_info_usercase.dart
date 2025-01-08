import 'package:dartz/dartz.dart';
import 'package:flutter_twitter_copy/domain/entities/user.dart';
import 'package:flutter_twitter_copy/domain/repositories/user_repository.dart';

class GetUserInfo {
  final UserRepository repository;

  GetUserInfo(this.repository);

  Future<Either<String, User>> call(String userId) async {
    return await repository.getUserInfo(userId);
  }
}
