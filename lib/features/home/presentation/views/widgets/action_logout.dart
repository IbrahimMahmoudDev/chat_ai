import 'package:flutter/material.dart';

import '../../../../../core/services/firebase_auth_services.dart';
import '../../../../../core/services/git_it_services.dart';
import '../../../../authiciation/presentation/views/login_view.dart';

class ActionLogOut extends StatelessWidget {
  const ActionLogOut({
    super.key,
    required this.colorScheme,
    required this.theme,
  });

  final ColorScheme colorScheme;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.logout, color: colorScheme.error),
      title: Text(
        'Log Out',
        style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.error),
      ),
      onTap: () async {
        try {
          // 1. Sign out من Firebase
          await getIt<FirebaseAuthServices>().signOut();

          // 2. Navigate للشاشة الرئيسية أو Login
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginView()),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Failed to logout. Please try again.",
                style: TextStyle(color: theme.colorScheme.error, fontSize: 18),
              ),
            ),
          );
        }
      },
    );
  }
}
