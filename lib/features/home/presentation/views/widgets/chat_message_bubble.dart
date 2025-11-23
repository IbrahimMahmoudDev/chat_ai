import 'package:flutter/material.dart';

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    super.key, required this.text, required this.isUser,
  });


  final String text;
  final bool isUser;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final userColor = isDark ? Colors.blue[700] : Colors.blue[400];
    final userTextColor = Colors.white;

    // ألوان الـ AI
    final aiColor = isDark ? Colors.grey[800] : Colors.grey[300];
    final aiTextColor = isDark ? Colors.white : Colors.black87;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? userColor : aiColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? userTextColor : aiTextColor,
          ),
        ),
      ),
    );
  }
}