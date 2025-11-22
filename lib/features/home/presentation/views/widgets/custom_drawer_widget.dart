import 'package:chat_ai/features/home/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper_function/get_user.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ==== 1. Header (User Info) ====
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: isDark ? Colors.brown : Colors.grey[200],),
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
                child: Icon(Icons.person, size: 40,color: isDark ? Colors.white : Colors.black, ),
              ),
            ),
          ),

          // ==== 2. Dark Mode Toggle ====
          ListTile(
            leading: Icon(Icons.dark_mode_outlined, color: theme.iconTheme.color),
            title: Text('Dark Mode', style: theme.textTheme.bodyMedium),
            trailing: BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return Switch(
                  value: state.themeMode == ThemeMode.dark,
                  activeColor: colorScheme.primary,
                  onChanged: (_) {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                );
              },
            ),
          ),

          const Divider(height: 30),

          // ==== 3. Log Out ====
          ListTile(
            leading: Icon(Icons.logout, color: colorScheme.error),
            title: Text(
              'Log Out',
              style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.error),
            ),
            onTap: () {
              // TODO: handle logout
            },
          ),
        ],
      ),
    );
  }
}
