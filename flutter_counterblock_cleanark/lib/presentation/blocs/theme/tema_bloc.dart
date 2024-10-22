import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counterblock_cleanark/config/tema/apptheme.dart';
import 'package:flutter_counterblock_cleanark/presentation/blocs/theme/tema_evento.dart';
import 'package:flutter_counterblock_cleanark/presentation/blocs/theme/tema_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(appTheme: AppTheme())) {
    on<ThemeChange>((event, emit) {
      final newTheme = AppTheme(
        isDarkmode: event.isDarkMode,
        selectedColor: event.selectedColor,
      );
      emit(ThemeState(appTheme: newTheme));
    });
  }
}
