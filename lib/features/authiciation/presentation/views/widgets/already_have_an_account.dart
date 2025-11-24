import 'package:flutter/material.dart';

import '../../../../../core/utils/app_style_text.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Already a member ?', style: AppTextStyles.regular14),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            ' Login in',
            style: AppTextStyles.regular14.copyWith(
              color: Colors.teal[400],
            ),
          ),
        ),
      ],
    );
  }
}