import 'package:chat_ai/core/utils/app_style_text.dart';
import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../generated/assets.dart';
import '../../../../authiciation/presentation/views/login_view.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Image.asset(Assets.imagesSplashImages),
          Text('Chat with AI Anytime, Anywhere', style: AppTextStyles.bold20),
          SizedBox(height: 10),
          Text(
            'Instant,smart answers powered by advanced artificial intelligence',
            textAlign: TextAlign.center,
            style: AppTextStyles.regular16,
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
