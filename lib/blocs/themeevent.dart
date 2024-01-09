import 'package:flutter/material.dart';

class ThemeEvent {}

class ToggleTheme extends ThemeEvent {}

class ThemeState {
  final ThemeData theme;

  ThemeState({required this.theme});
}
