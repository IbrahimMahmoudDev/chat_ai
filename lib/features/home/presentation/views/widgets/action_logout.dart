import 'package:flutter/material.dart';

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
      onTap: () {
        // TODO: handle logout
      },
    );
  }
}