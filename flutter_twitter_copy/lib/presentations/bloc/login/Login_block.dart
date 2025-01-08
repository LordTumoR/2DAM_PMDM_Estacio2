import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_copy/domain/usercases/get_user_info_usercase.dart';
import 'package:flutter_twitter_copy/domain/usercases/get_users_usercase.dart';
import 'package:flutter_twitter_copy/domain/usercases/login_user_usercase.dart';
import 'package:flutter_twitter_copy/domain/usercases/updateUser_usercase.dart';
import 'package:flutter_twitter_copy/presentations/bloc/login/Login_event.dart';
import 'package:flutter_twitter_copy/presentations/bloc/login/login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_twitter_copy/injection.dart' as di;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUser;
  final GetUserInfo getUserInfo;
  final GetUsers getUsers;
  final UpdateUserInfoUseCase updateUserInfoUseCase;

  LoginBloc({
    required this.loginUser,
    required this.getUserInfo,
    required this.updateUserInfoUseCase,
    required this.getUsers,
  }) : super(LoginState.initial()) {
    on<LoginButtonPressed>(_loginUser);
    on<GetUserInfoEvent>(_getUserInfo);
    on<UpdateUserInfoEvent>(_updateUserInfo);
    on<LogoutButtonPressed>(_logoutButton);
    on<GetUsersEvent>(_getUsers);
  }

  Future<void> _loginUser(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    print('Evento de login iniciado para usuario: ${event.username}');
    emit(state.copyWith(isLoading: true));

    try {
      final result = await loginUser(event.username, event.password);
      await result.fold(
        (error) async {
          print('Error al iniciar sesión: $error');
          emit(state.copyWith(isLoading: false, errorMessage: error));
        },
        (username) async {
          print('Inicio de sesión exitoso. Usuario ID: ${username.id}');
          final prefs = di.sl<SharedPreferences>();
          await prefs.setString('user_id', username.id);
          print('User ID guardado en SharedPreferences: ${username.id}');

          add(GetUserInfoEvent(userId: username.id));

          emit(state.copyWith(isLoading: false, username: username));
        },
      );
    } catch (e) {
      print('Error inesperado durante el login: $e');
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Error inesperado: $e'));
    }
  }

  Future<void> _getUserInfo(
    GetUserInfoEvent event,
    Emitter<LoginState> emit,
  ) async {
    print('Obteniendo información del usuario con ID: ${event.userId}');
    emit(state.copyWith(isLoading: true));

    try {
      final result = await getUserInfo(event.userId);
      result.fold(
        (error) {
          print('Error al obtener información del usuario: $error');
          emit(state.copyWith(isLoading: false, errorMessage: error));
        },
        (username) {
          print(
              'Información del usuario obtenida con éxito: ${username.username}');
          emit(state.copyWith(isLoading: false, username: username));
        },
      );
    } catch (e) {
      print('Error inesperado al obtener información del usuario: $e');
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Error inesperado: $e'));
    }
  }

  Future<void> _getUsers(
    GetUsersEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, searchedUsers: []));
    try {
      final result = await getUsers();
      result.fold(
        (error) => emit(state.copyWith(isLoading: false, errorMessage: error)),
        (users) {
          final filteredUsers = event.query.isNotEmpty
              ? users
                  .where((user) => user.username
                      .toLowerCase()
                      .contains(event.query.toLowerCase()))
                  .toList()
              : users;

          emit(state.copyWith(isLoading: false, searchedUsers: filteredUsers));
        },
      );
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Error inesperado: $e'));
    }
  }

  Future<void> _updateUserInfo(
    UpdateUserInfoEvent event,
    Emitter<LoginState> emit,
  ) async {
    print('Actualizando información del usuario: ${event.username}');
    emit(state.copyWith(isLoading: true));

    try {
      final result = await updateUserInfoUseCase(
          event.userId, event.username, event.avatar);

      result.fold(
        (error) {
          print('Error al actualizar la información del usuario: $error');
          emit(state.copyWith(isLoading: false, errorMessage: error));
        },
        (success) {
          print('Información del usuario actualizada con éxito');
          emit(state.copyWith(isLoading: false, updateSuccess: true));
        },
      );
    } catch (e) {
      print('Error inesperado al actualizar la información del usuario: $e');
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Error inesperado: $e'));
    }
  }

  Future<void> _logoutButton(
    LogoutButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    print('Iniciando el proceso de logout');
    emit(state.copyWith(isLoading: true));

    try {
      final prefs = di.sl<SharedPreferences>();
      await prefs.remove('user_id');
      print('User ID eliminado de SharedPreferences');

      emit(LoginState.initial());
      print('Logout completado con éxito');
    } catch (e) {
      print('Error inesperado durante el logout: $e');
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Error inesperado: $e'));
    }
  }
}
