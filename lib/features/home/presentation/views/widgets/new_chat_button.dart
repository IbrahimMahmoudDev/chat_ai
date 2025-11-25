import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/ConversationsCubit/conversations_cubit.dart';
import '../../manager/chat_cubit/chat_cubit.dart';

class NewChatButton extends StatelessWidget {
  const NewChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final iconColor = isDark ? Colors.white : Colors.black;
    final textColor = iconColor;
    final backgroundColor = isDark ? Colors.grey[850] : Colors.teal[100];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        onPressed: () {
          final newId = context.read<ConversationsCubit>().createNewChat();
          context.read<ChatCubit>().loadChat(newId);
          Navigator.pop(context);
        },
        icon: Icon(Icons.add, color: iconColor),
        label: Text("New Chat", style: TextStyle(color: textColor)),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
    );
  }
}
