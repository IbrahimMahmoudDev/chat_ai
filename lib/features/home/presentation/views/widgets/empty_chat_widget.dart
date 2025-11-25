import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/ConversationsCubit/conversations_cubit.dart';
import '../../manager/chat_cubit/chat_cubit.dart';

class EmptyChatWidget extends StatelessWidget {
  const EmptyChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.chat_bubble_outline,
              size: 80, color: isDark ? Colors.white54 : Colors.black54),
          const SizedBox(height: 20),
           Text(
            "No Messages Yet",
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          Text(
            "Start a new chat to see your conversation here.",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              final chatId = context.read<ConversationsCubit>().createNewChat();
              context.read<ChatCubit>().loadChat(chatId);
            },
            icon: const Icon(Icons.add),
            label: const Text("New Chat"),
          ),
        ],
      ),
    );
  }
}
