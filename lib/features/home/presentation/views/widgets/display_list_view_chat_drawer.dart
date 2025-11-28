import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/chat_model.dart';
import '../../manager/chat_cubit/chat_cubit.dart';
import '../../manager/conversations_cubit/conversations_cubit.dart';

class DisplayListViewChatDrawer extends StatelessWidget {
  const DisplayListViewChatDrawer({
    super.key,
    required this.isCurrent,
    required this.colorScheme,
    required this.chat,
  });

  final bool isCurrent;
  final ColorScheme colorScheme;
  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        selected: isCurrent,
        selectedTileColor: colorScheme.primary.withOpacity(0.1),
        title: Text(
          chat.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          context.read<ChatCubit>().loadChat(chat.id);
          Navigator.pop(context);
        },
        onLongPress: () async {
          final controller = TextEditingController(text: chat.title);
          final newTitle = await showDialog<String>(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Edit Chat Title"),
              content: TextField(controller: controller),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("cancel"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, controller.text.trim());
                  },
                  child: const Text("save"),
                ),
              ],
            ),
          );

          if (newTitle != null && newTitle.isNotEmpty) {
            context.read<ConversationsCubit>().updateChatTitle(chat.id, newTitle);
          }
        },
        trailing: IconButton(
          icon: Icon(Icons.delete, color: colorScheme.error),
          onPressed: () {
            final chatCubit = context.read<ChatCubit>();
            final conversationsCubit = context.read<ConversationsCubit>();
            if (isCurrent) {
              chatCubit.deleteCurrentAndStartNew();
              conversationsCubit.loadAllChats();
            } else {
              conversationsCubit.deleteChat(chat.id);
              conversationsCubit.loadAllChats();
            }

            Navigator.pop(context); // إغلاق الـ Drawer
          },
        )


    );
  }
}