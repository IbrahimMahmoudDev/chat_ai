

  import 'package:chat_ai/features/splash_view/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {

  switch(settings.name) {
    case SplashView.routeName :
      return MaterialPageRoute(builder: (context) => const SplashView());
    default :
      return MaterialPageRoute(builder: (context) => Scaffold());

  }
  }