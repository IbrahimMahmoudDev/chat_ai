import 'package:chat_ai/features/home/presentation/views/widgets/empty_chat_widget.dart';
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
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              if (state.isEmptyChat) {
                return EmptyChatWidget();
              }

              return Column(
                children: [
                  Expanded(
                    child: ChatMessagesListView(
                      controller: scrollController,
                      messages: state.currentChat!.messages,
                    ),
                  ),
                  if (state.isLoading) const AiTypingIndicator(),
                ],
              );
            },
          ),
        ),
        TextFormFieldChat(
          controller: controller,
          onFieldSubmitted: (value) {
            context.read<ChatCubit>().sendMessage(value, context);
            controller.clear();
            scrollToBottom();
          },
        ),
      ],
    );
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }
}

// Extension لتسهيل التحقق من شات فارغ
extension ChatStateExtension on ChatState {
  bool get isEmptyChat => currentChat == null || currentChat!.messages.isEmpty;
}
