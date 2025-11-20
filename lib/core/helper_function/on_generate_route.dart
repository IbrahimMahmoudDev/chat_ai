import 'package:chat_ai/features/home/presentation/views/main_view.dart';
import 'package:chat_ai/features/splash_view/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';

import '../../features/authiciation/presentation/views/login_view.dart';
import '../../features/authiciation/presentation/views/signup_view.dart';
import '../../features/on_boarding_screen/presentation/views/on_board_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case OnBoardView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardView());
    case LoginView.routeName:
      return MaterialPageRoute(builder: (context) => const LoginView());
    case SignupView.routeName:
      return MaterialPageRoute(builder: (context) => const SignupView());
    case MainView.routeName:
      return MaterialPageRoute(builder: (context) => const MainView());
    default:
      return MaterialPageRoute(builder: (context) => Scaffold());
  }
}
