

  import 'package:chat_ai/features/splash_view/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';

import '../../features/on_boarding_screen/presentation/views/on_board_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {

  switch(settings.name) {
    case SplashView.routeName :
      return MaterialPageRoute(builder: (context) => const SplashView());
      case OnBoardView.routeName :
      return MaterialPageRoute(builder: (context) => const OnBoardView());

    default :
      return MaterialPageRoute(builder: (context) => Scaffold());

  }
  }