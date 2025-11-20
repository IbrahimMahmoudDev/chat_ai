import 'package:chat_ai/core/widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import '../../../../../core/helper_function/get_greeting.dart';
import '../../../../../core/helper_function/get_user.dart';

import '../../../../../core/utils/app_style_text.dart';
import '../../../../../generated/assets.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: Image.asset(Assets.imagesImageProfile),
      title: Text(
        "!.. ${getGreeting()}",
        style: AppTextStyles.semibold16.copyWith(color: Color(0xFFA8AFB0)),
      ),
      subtitle: Text(
        getUser().name,
        style: AppTextStyles.bold16.copyWith(color: Color(0xFF121313)),
      ),
      trailing: NotificationWidget()
    );
  }
}


