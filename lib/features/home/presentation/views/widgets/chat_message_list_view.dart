import 'package:flutter/material.dart';

import '../../../data/models/chat_message.dart';
import 'chat_message_bubble.dart';

class ChatMessagesListView extends StatelessWidget {
  final ScrollController controller;
  final List<ChatMessage>? messages; // خليها nullable

  const ChatMessagesListView({
    super.key,
    required this.controller,
    this.messages,
  });

  @override
  Widget build(BuildContext context) {
    final chatMessages = messages ?? [];
    final theme = Theme.of(context);
    if (chatMessages.isEmpty) {
      return Center(
        child: Text(
          "No messages yet",
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.disabledColor),
        ),
      );
    }

    return ListView.builder(
      controller: controller,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(16),
      itemCount: chatMessages.length,
      itemBuilder: (context, index) {
        final msg = chatMessages[index];
        return ChatMessageBubble(
          text: msg.text,
          isUser: msg.isUser,
        );
      },
    );
  }
}
