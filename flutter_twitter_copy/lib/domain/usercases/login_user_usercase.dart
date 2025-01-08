import 'package:dartz/dartz.dart';
import 'package:flutter_twitter_copy/domain/entities/user.dart';
import 'package:flutter_twitter_copy/domain/repositories/user_repository.dart';

class LoginUseCase {
  final UserRepository repository;

  LoginUseCase(this.repository);

  Future<Either<String, User>> call(String username, String password) async {
    return await repository.login(username, password);
  }
}
