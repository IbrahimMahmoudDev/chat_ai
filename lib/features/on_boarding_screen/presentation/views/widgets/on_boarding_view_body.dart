import 'package:flutter/cupertino.dart';

import '../../../../../generated/assets.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Assets.imagesSplashImages),

      ],
    );
  }
}
