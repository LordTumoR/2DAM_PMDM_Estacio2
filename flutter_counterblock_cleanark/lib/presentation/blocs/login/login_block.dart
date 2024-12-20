import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counterblock_cleanark/domain/repositories/login_repository.dart';
import 'package:flutter_counterblock_cleanark/domain/usercases/login_user_usercase.dart';
import 'package:flutter_counterblock_cleanark/presentation/blocs/login/login_event.dart';
import 'package:flutter_counterblock_cleanark/presentation/blocs/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUser;
  final LoginRepository authRepository;

  LoginBloc(this.loginUser, this.authRepository) : super(const LoginState()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final result = await loginUser(event.email, event.password);
      result.fold(
        (error) => emit(
            state.copyWith(isLoading: false, errorMessage: error.toString())),
        (user) => emit(state.copyWith(isLoading: false, user: user)),
      );
    });

    on<LogoutButtonPressed>((event, emit) async {
      await authRepository.logout();
      emit(const LoginState());
    });
  }
}
