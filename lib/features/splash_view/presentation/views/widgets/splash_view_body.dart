import 'dart:async';

import 'package:chat_ai/features/authiciation/presentation/views/login_view.dart';
import 'package:chat_ai/features/on_boarding_screen/presentation/views/on_board_view.dart';
import 'package:chat_ai/generated/assets.dart';
import 'package:flutter/material.dart';

import '../../../../../core/services/firebase_auth_services.dart';
import '../../../../../core/services/shared_prefrence_singleton.dart';
import '../../../../../core/utils/constant.dart';
import '../../../../home/presentation/views/main_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    executeNavigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Image.asset(Assets.imagesAppLogo)],
    );
  }


  void executeNavigation() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final auth = FirebaseAuthServices();

    /// 1) لو المستخدم مش عامل تسجيل دخول → روح Login
    if (!auth.isLoggedIn()) {
      Navigator.pushReplacementNamed(context, LoginView.routeName);
      return;
    }

    /// 2) المستخدم عامل تسجيل دخول… نشوف هل شاف OnBoarding ولا لأ
    bool onboardingSeen = Prefs.getBool(kOnBoardingSeen) ?? false;

    if (!onboardingSeen) {
      /// أول مرة يدخل بعد تسجيل حساب جديد
      Navigator.pushReplacementNamed(context, OnBoardView.routeName);
    } else {
      /// خلاص شاف الـ Onboarding
      Navigator.pushReplacementNamed(context, MainView.routeName);
    }
  }

}


