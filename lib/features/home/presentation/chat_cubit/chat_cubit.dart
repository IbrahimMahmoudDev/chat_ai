
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/chat_message.dart';
import '../../domain/chat_repo.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepo repo;

  ChatCubit(this.repo)
      : super(ChatState(messages: [], isLoading: false));

  Future<void> sendMessage(String text) async {
    // 1) Add user message
    final userMsg = ChatMessage(text: text, isUser: true);
    emit(state.copyWith(messages: [...state.messages, userMsg], isLoading: true));

    // 2) Prepare AI message
    final aiMsg = ChatMessage(text: '', isUser: false);
    state.messages.add(aiMsg);

    // 3) Streaming from AI
    await for (var chunk in repo.grokStream(text)) {
      aiMsg.text += chunk;

      emit(
        state.copyWith(messages: [...state.messages]),
      );
    }

    emit(state.copyWith(isLoading: false));
  }
}

