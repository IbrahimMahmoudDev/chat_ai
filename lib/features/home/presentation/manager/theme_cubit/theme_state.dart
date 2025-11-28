part of 'theme_cubit.dart';

@immutable
class ThemeState {
  final ThemeData themeData;
  final bool isDark;

  const ThemeState({
    required this.themeData,
    required this.isDark,
  });
}
