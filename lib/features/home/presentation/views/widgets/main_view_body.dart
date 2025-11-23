import 'package:chat_ai/features/home/presentation/views/widgets/text_form_field_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manager/chat_cubit/chat_cubit.dart';
import 'ai_typing_indicator.dart';
import 'chat_message_list_view.dart';

class MainViewBody extends StatefulWidget {
  const MainViewBody({super.key});

  @override
  State<MainViewBody> createState() => _MainViewBodyState();
}

class _MainViewBodyState extends State<MainViewBody> {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Expanded(
          child: BlocBuilder<ChatCubit, ChatState>(

            builder: (context, state) {
              final theme = Theme.of(context);
              final isDark = theme.brightness == Brightness.dark;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                scrollToBottom();
              });
              if (state.currentChat == null || state.currentChat!.messages.isEmpty) {
                return  Center(
                  child: Text(" Create a New Chat Conversation",style: TextStyle(
                    fontSize: theme.textTheme.bodyLarge?.fontSize,
                    color: isDark ? Colors.white : Colors.black,
                  ),),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: ChatMessagesListView(
                      controller: scrollController,
                      messages:state.currentChat?.messages ?? [],
                    ),
                  ),

                  if (state.isLoading) AiTypingIndicator(),
                ],
              );
            },
          ),
        ),

        TextFormFieldChat(
          controller: controller,
          onFieldSubmitted: (value) {
            context.read<ChatCubit>().sendMessage(value);
            controller.clear();
          },
        ),
      ],
    );
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
