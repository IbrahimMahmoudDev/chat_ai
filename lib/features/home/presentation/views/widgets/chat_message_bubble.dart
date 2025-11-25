import 'package:chat_ai/features/authiciation/presentation/views/widgets/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    super.key, required this.text, required this.isUser,
  });


  final String text;
  final bool isUser;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final userColor = isDark ? Colors.blue[700] : Colors.blue[400];
    final userTextColor = Colors.white;

    // ألوان الـ AI
    final aiColor = isDark ? Colors.grey[800] : Colors.grey[300];
    final aiTextColor = isDark ? Colors.white : Colors.black87;
    return GestureDetector(
      onLongPress: (){
        Clipboard.setData(ClipboardData(text: text));
        showSnackBar(context, 'Copied!', Colors.green);
      },
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isUser ? userColor : aiColor,
            borderRadius: BorderRadius.circular(12),
          ),
            child: SelectableText(
              text,
              style: TextStyle(
                color: isUser ? userTextColor : aiTextColor,
              ),
            ),

        ),
      ),
    );
  }
}