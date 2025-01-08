import 'package:dartz/dartz.dart';
import 'package:flutter_twitter_copy/domain/entities/user.dart';
import 'package:flutter_twitter_copy/domain/repositories/user_repository.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<Either<String, List<User>>> call() async {
    return await repository.getUsers();
  }
}
