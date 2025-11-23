import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/theme_cubit/theme_cubit.dart';

class DarkThemeListTile extends StatelessWidget {
  const DarkThemeListTile({
    super.key,
    required this.theme,
    required this.colorScheme,
  });

  final ThemeData theme;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.dark_mode_outlined, color: theme.iconTheme.color),
      title: Text('Dark Mode', style: theme.textTheme.bodyMedium),
      trailing: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return Switch(
            value: state.themeMode == ThemeMode.dark,
            activeColor: colorScheme.primary,
            onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
          );
        },
      ),
    );
  }
}