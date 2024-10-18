import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeChange extends ThemeEvent {
  final bool isDarkMode;
  final int selectedColor;

  const ThemeChange({required this.isDarkMode, required this.selectedColor});

  @override
  List<Object> get props => [isDarkMode, selectedColor];
}
