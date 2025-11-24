import 'package:flutter/material.dart';

import 'list_tile_action_button.dart';

class ActionLogOut extends StatelessWidget {
  const ActionLogOut({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return ListTileActionButton(
      colorScheme: colorScheme,
      theme: theme,
      isDark: isDark,
    );
  }
}
