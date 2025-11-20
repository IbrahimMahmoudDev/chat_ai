import 'package:flutter/material.dart';

import '../../../../../core/helper_function/get_user.dart';
import '../../../../../core/utils/app_style_text.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding:
        EdgeInsets.zero, // خليها zero عشان الـ UserInfo ياخد المساحة كويس
        children: [
          // ==== 1. Header (User Info) ====
          UserAccountsDrawerHeader(
            accountName: Text(
              getUser().name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            accountEmail: Text(
              getUser().email ?? "user@example.com",
              style: const TextStyle(fontSize: 14),
            ),
            currentAccountPicture: CircleAvatar(
              radius: 40,
              child: Icon(Icons.person, size: 40),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: const Text('Dark Mode', style: AppTextStyles.regular16),
            trailing: Switch(
              value: false,
              activeColor: Colors.deepPurple,
              onChanged: (value) {},
            ),
          ),

          const Divider(height: 30),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'LogOut',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {},
          ),

        ],
      ),
    );
  }
}