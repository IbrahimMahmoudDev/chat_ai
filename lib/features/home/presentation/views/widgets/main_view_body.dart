import 'package:chat_ai/features/home/presentation/chat_cubit/chat_cubit.dart';
import 'package:chat_ai/features/home/presentation/views/widgets/text_form_field_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainViewBody extends StatefulWidget {
  const MainViewBody({super.key});

  @override
  State<MainViewBody> createState() => _MainViewBodyState();
}

class _MainViewBodyState extends State<MainViewBody> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              return ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: state.messages.length,
                itemBuilder: (context, index) {
                  final msg = state.messages[index];
                  return Align(
                    alignment: msg.isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: msg.isUser ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        msg.text,
                        style: TextStyle(
                          color: msg.isUser ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
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
}
