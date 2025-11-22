import 'package:flutter/material.dart';

import '../../../data/models/chat_message.dart';
import 'chat_message_bubble.dart';

class ChatMessagesListView extends StatelessWidget {
  final ScrollController controller;
  final List<ChatMessage> messages;

  const ChatMessagesListView({
    super.key,
    required this.controller,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];
        return ChatMessageBubble(
          text: msg.text,
          isUser: msg.isUser,
        );
      },
    );
  }
}
