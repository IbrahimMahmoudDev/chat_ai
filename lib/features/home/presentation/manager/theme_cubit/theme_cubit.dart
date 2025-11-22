import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/shared_prefrence_singleton.dart';
import '../../../../../core/utils/constant.dart';


part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {

  ThemeCubit() : super(ThemeState(ThemeMode.light)) {
    // قراءة الوضع المخزن عند البداية
    final isDark = Prefs.getBool(kIsDarkMode);
    if (isDark) {
      emit(ThemeState(ThemeMode.dark));
    } else {
      emit(ThemeState(ThemeMode.light));
    }
  }

  void toggleTheme() {
    final newMode = state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(ThemeState(newMode));
    // حفظ الوضع الجديد
    Prefs.setBool(kIsDarkMode, newMode == ThemeMode.dark);
  }

  void setTheme(ThemeMode mode) {
    emit(ThemeState(mode));
    Prefs.setBool(kIsDarkMode, mode == ThemeMode.dark);
  }
}

