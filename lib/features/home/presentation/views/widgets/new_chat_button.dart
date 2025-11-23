import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/ConversationsCubit/conversations_cubit.dart';
import '../../manager/chat_cubit/chat_cubit.dart';

class NewChatButton extends StatelessWidget {
  const NewChatButton({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        onPressed: () {
          final newId = context.read<ConversationsCubit>().createNewChat();
          context.read<ChatCubit>().loadChat(newId);
          Navigator.pop(context);
        },
        icon:  Icon(Icons.add,color: isDark ? Colors.white : Colors.black,),
        label:  Text("New Chat",style: TextStyle(
          color: isDark ? Colors.white : Colors.black,
        ),),
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? Colors.black.withOpacity(1) : Colors.teal[50],
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
    );
  }
}