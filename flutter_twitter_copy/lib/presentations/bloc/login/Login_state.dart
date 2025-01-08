import 'package:equatable/equatable.dart';
import 'package:flutter_twitter_copy/domain/entities/user.dart';

class LoginState extends Equatable {
  final User? username;
  final bool isLoading;
  final String errorMessage;
  final bool updateSuccess;
  final List<User> searchedUsers;

  const LoginState({
    this.username,
    this.isLoading = false,
    this.errorMessage = '',
    this.updateSuccess = false,
    this.searchedUsers = const [],
  });

  factory LoginState.initial() {
    return const LoginState(
      username: null,
      isLoading: false,
      errorMessage: '',
      updateSuccess: false,
      searchedUsers: [],
    );
  }

  LoginState copyWith({
    User? username,
    bool? isLoading,
    String? errorMessage,
    bool? updateSuccess,
    List<User>? searchedUsers,
  }) {
    return LoginState(
      username: username ?? this.username,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      updateSuccess: updateSuccess ?? this.updateSuccess,
      searchedUsers: searchedUsers ?? this.searchedUsers,
    );
  }

  @override
  List<Object?> get props =>
      [username, isLoading, errorMessage, updateSuccess, searchedUsers];
}
