import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../generated/assets.dart';
import '../../../../authiciation/presentation/views/login_view.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Image.asset(isDark ? Assets.imagesSplashImageDark : Assets.imagesSplashImages),
          SizedBox(height: 10),
          Text('Chat with AI Anytime, Anywhere', style:theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
          SizedBox(height: 10),
          Text(
            'Instant,smart answers powered by advanced artificial intelligence',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleSmall?.copyWith(color: theme.hintColor),
          ),
          Spacer(),
          CustomButton(
            onPressed: () {
            Navigator.pushNamed(context, LoginView.routeName);
            },
            text: 'Get Started',
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
