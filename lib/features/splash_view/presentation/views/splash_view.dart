import 'package:chat_ai/features/splash_view/presentation/views/widgets/splash_view_body.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  static const String routeName = 'splash_view';
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SplashViewBody(),
    );
  }
}
