import 'package:flutter/material.dart';

import '../../../../../core/helper_function/get_user.dart';

class DisplayPersonAccount extends StatelessWidget {
  const DisplayPersonAccount({
    super.key,
    required this.isDark,
    required this.theme,
  });

  final bool isDark;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: isDark ? Colors.brown : Colors.grey[200],
      ),
      accountName: Text(
        getUser().name,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
      accountEmail: Text(
        getUser().email ?? "user@example.com",
        style: theme.textTheme.bodyMedium?.copyWith(
          color: isDark ? Colors.white70 : Colors.black87,
        ),
      ),
      currentAccountPicture: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          radius: 40,
          backgroundColor: isDark ? Colors.black87 : Colors.white,
          child: Icon(
            Icons.person,
            size: 40,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}