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
      // leading: Image.asset(Assets.imagesImageProfile),
      title: Text(
        "!.. ${getGreeting()}",
        style: AppTextStyles.semibold16.copyWith(color: theme.textTheme.bodySmall?.color,),
      ),
      subtitle: Text(
        getUser().name,
        style: AppTextStyles.bold16.copyWith(color: theme.textTheme.headlineMedium?.color),
      ),
      trailing: Image.asset(Assets.imagesImageProfile),
    );
  }
}
