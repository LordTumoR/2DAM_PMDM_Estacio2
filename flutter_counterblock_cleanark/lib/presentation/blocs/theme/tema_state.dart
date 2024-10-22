import 'package:equatable/equatable.dart';
import 'package:flutter_counterblock_cleanark/config/tema/apptheme.dart';

class ThemeState extends Equatable {
  final AppTheme appTheme;

  const ThemeState({required this.appTheme});

  @override
  List<Object> get props => [appTheme];
}
