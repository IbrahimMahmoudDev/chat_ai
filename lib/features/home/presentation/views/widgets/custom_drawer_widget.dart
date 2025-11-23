import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/helper_function/get_user.dart';
import '../../../../../core/services/chat_services.dart';
import '../../manager/chat_cubit/chat_cubit.dart';
import '../../manager/theme_cubit/theme_cubit.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final chatService = GetIt.instance<ChatService>();
    final chats = chatService.getAllChats();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ==== Header ====
          UserAccountsDrawerHeader(
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
          ),

          // ==== Dark Mode Toggle ====
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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("Chats", style: theme.textTheme.titleMedium),
          ),

          // ==== قائمة المحادثات ====
          ...chats.map((chat) {
            return ListTile(
              title: GestureDetector(
                child: Text(chat.title),
                onTap: () {
                  context.read<ChatCubit>().loadChat(chat.id);
                  Navigator.pop(context);
                },
                onLongPress: () async {
                  // تعديل اسم المحادثة
                  final controller = TextEditingController(text: chat.title);
                  await showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("Edit Chat Title"),
                      content: TextField(controller: controller),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            final newTitle = controller.text.trim();
                            if (newTitle.isNotEmpty) {
                              chatService.updateChatTitle(chat.id, newTitle);
                              Navigator.pop(context);
                              (context as Element).markNeedsBuild(); // إعادة بناء الـ Drawer
                            }
                          },
                          child: Text("Save"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  chatService.deleteChat(chat.id);
                  if (context.read<ChatCubit>().state.currentChat?.id == chat.id) {
                    context.read<ChatCubit>().loadChat(""); // فرغ currentChat لو كانت مفتوحة
                  }
                  (context as Element).markNeedsBuild(); // إعادة بناء الـ Drawer
                },
              ),
            );
          }).toList(),

          // ==== زر إضافة محادثة جديدة ====
          ListTile(
            leading: Icon(Icons.add),
            title: Text("New Chat"),
            onTap: () {
              final newId = chatService.createNewChat(title: "Chat ${chats.length + 1}");
              context.read<ChatCubit>().loadChat(newId);
              Navigator.pop(context);
            },
          ),

          const Divider(height: 30),

          // ==== Log Out ====
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
