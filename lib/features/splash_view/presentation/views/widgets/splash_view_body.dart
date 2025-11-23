import 'dart:async';

import 'package:chat_ai/features/authiciation/presentation/views/login_view.dart';
import 'package:chat_ai/generated/assets.dart';
import 'package:flutter/material.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    executeToNavigate();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Image.asset(Assets.imagesAppLogo)],
    );
  }

  Timer executeToNavigate() {
    return Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, LoginView.routeName);
    });
  }
}
