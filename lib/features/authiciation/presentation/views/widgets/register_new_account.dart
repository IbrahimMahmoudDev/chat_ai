import 'package:flutter/material.dart';

import '../../../../../core/utils/app_style_text.dart';
import '../signup_view.dart';

class RegisterNewAccount extends StatelessWidget {
  const RegisterNewAccount ({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('New member ?', style: AppTextStyles.regular14),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, SignupView.routeName);
          },
          child: Text(
            ' Register now',
            style: AppTextStyles.regular14.copyWith(
              color: Colors.teal[400],
            ),
          ),
        ),
      ],
    );
  }
}