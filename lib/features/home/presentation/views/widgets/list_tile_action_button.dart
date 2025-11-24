import 'package:flutter/material.dart';

import '../../../../../core/services/firebase_auth_services.dart';
import '../../../../../core/services/git_it_services.dart';
import '../../../../authiciation/presentation/views/login_view.dart';
import '../../../../authiciation/presentation/views/widgets/show_snack_bar.dart';

class ListTileActionButton extends StatelessWidget {
  const ListTileActionButton({
    super.key,
    required this.colorScheme,
    required this.theme,
    required this.isDark,
  });

  final ColorScheme colorScheme;
  final ThemeData theme;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.logout, color: colorScheme.error),
      title: Text(
        'Log Out',
        style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.error),
      ),
      onTap: () async {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor:
            isDark ? Color(0xFF1E1E1E) : Colors.white, // Background
            title: Text(
              'Confirm Logout',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Are you sure you want to log out?',
              style: TextStyle(
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400], // Confirm button always red
                ),
                onPressed: () async {
                  try {
                    await getIt<FirebaseAuthServices>().signOut();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const LoginView()),
                    );
                  } catch (e) {
                    Navigator.of(context).pop(); // Close dialog
                    showSnackBar(context, "Failed to logout. Please try again.", Colors.white);
                  }
                },
                child: Text('Confirm',style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        );
      },
    );
  }
}
