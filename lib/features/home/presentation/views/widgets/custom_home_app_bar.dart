import 'package:flutter/material.dart';
import '../../../../../core/helper_function/get_greeting.dart';
import '../../../../../core/helper_function/get_user.dart';

import '../../../../../core/utils/app_style_text.dart';
import '../../../../../generated/assets.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      // leading: Image.asset(Assets.imagesImageProfile),
      title: Text(
        "!.. ${getGreeting()}",
        style: AppTextStyles.semibold16.copyWith(
          color: theme.brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
      ),
      subtitle: Text(
        getUser().name,
        style: AppTextStyles.bold16.copyWith(
          color: theme.brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
      ),
      trailing: Image.asset(Assets.imagesImageProfile),
    );
  }
}
