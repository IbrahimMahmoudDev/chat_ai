import 'package:chat_ai/features/home/presentation/chat_cubit/chat_cubit.dart';
import 'package:chat_ai/features/home/presentation/views/widgets/text_form_field_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ai_typing_indicator.dart';
import 'chat_message_bubble.dart';

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
              WidgetsBinding.instance.addPostFrameCallback((_) {
                scrollToBottom();
              });
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      controller: scrollController,
                      padding: EdgeInsets.all(16),
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final msg = state.messages[index];
                        return ChatMessageBubble(
                          text: msg.text,
                          isUser: msg.isUser,
                        );
                      },
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
