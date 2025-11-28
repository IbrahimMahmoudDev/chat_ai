import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/shared_prefrence_singleton.dart';
import '../../../../../core/utils/app_theme.dart';
import '../../../../../core/utils/constant.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
    : super(ThemeState(themeData: AppTheme.lightTheme, isDark: false)) {
    // تحميل القيمة من SharedPreferences بعد البناء الأول
    final stored = Prefs.getBool(kIsDarkMode);

    final isDark = stored ?? false; // ← مستحيل تبقى null

    emit(
      ThemeState(
        themeData: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
        isDark: isDark,
      ),
    );
  }

  void toggleTheme() {
    final newIsDark = !state.isDark;

    emit(
      ThemeState(
        themeData: newIsDark ? AppTheme.darkTheme : AppTheme.lightTheme,
        isDark: newIsDark,
      ),
    );

    Prefs.setBool(kIsDarkMode, newIsDark);
  }
}
