import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/chat_model.dart';
import '../../manager/ConversationsCubit/conversations_cubit.dart';
import '../../manager/chat_cubit/chat_cubit.dart';
import 'action_logout.dart';
import 'dark_theme_list_tile.dart';
import 'display_list_view_chat_drawer.dart';
import 'display_person_account.dart';
import 'new_chat_button.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Drawer(
      child: Column(
        children: [
          // ==== Header ====
          DisplayPersonAccount(isDark: isDark, theme: theme),

          // ==== Dark Mode Toggle ====
          DarkThemeListTile(theme: theme, colorScheme: colorScheme),

          const Divider(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("Chats", style: theme.textTheme.titleMedium),
          ),

          // ==== قايمة المحادثات (بتتحدث تلقائي بفضل BlocBuilder) ====
          Expanded(
            child: BlocBuilder<ConversationsCubit, List<ChatModel>>(
              builder: (context, chats) {
                if (chats.isEmpty) {
                  return const Center(child: Text("No Chats Here"));
                }

                // حساب currentChatId مرة واحدة
                final currentChatId = context
                    .read<ChatCubit>()
                    .state
                    .currentChat
                    ?.id;

                return ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    final isCurrent = currentChatId == chat.id; // مقارنة مباشرة

                    return DisplayListViewChatDrawer(
                      isCurrent: isCurrent,
                      colorScheme: colorScheme,
                      chat: chat,
                    );
                  },
                );
              },
            ),
          ),

          // ==== زر محادثة جديدة ====
          NewChatButton(isDark: isDark),

          const Divider(height: 30),

          // ==== Log Out ====
          ActionLogOut(),
        ],
      ),
    );
  }
}
