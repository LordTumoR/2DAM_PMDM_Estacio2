import 'package:equatable/equatable.dart';

// Eventos
abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  LoginButtonPressed(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}

class GetUsersEvent extends LoginEvent {
  final String query;

  GetUsersEvent({this.query = ''});

  @override
  List<Object?> get props => [query];
}

class GetUserInfoEvent extends LoginEvent {
  final String userId;

  GetUserInfoEvent({required this.userId});
}

class UpdateUserInfoEvent extends LoginEvent {
  final String userId;
  final String? username;
  final String? avatar;

  UpdateUserInfoEvent({required this.userId, this.username, this.avatar});
}

class LogoutButtonPressed extends LoginEvent {}
