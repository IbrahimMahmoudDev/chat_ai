
import 'package:flutter/material.dart';

import 'widgets/on_boarding_view_body.dart';

class OnBoardView extends StatelessWidget {
  const OnBoardView({super.key});
static const String routeName = 'on_boarding_view';
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: OnBoardingViewBody(),
    );
  }
}
