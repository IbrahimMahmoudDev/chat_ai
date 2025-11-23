
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/chat_services.dart';
import '../../../data/models/chat_message.dart';
import '../../../data/models/chat_model.dart';
import '../../../domain/chat_repo.dart';


part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatService chatService;
  final ChatRepo repo;

  ChatCubit({required this.chatService, required this.repo})
      : super(const ChatState(isLoading: false));

  // تحميل شات موجود
  void loadChat(String chatId) {
    final chat = chatService.getChat(chatId);
    emit(state.copyWith(currentChat: chat));
  }

  // إرسال رسالة المستخدم + AI
  Future<void> sendMessage(String text) async {
    if (state.currentChat == null) return;

    emit(state.copyWith(isLoading: true));

    // رسالة المستخدم
    final userMsg = ChatMessage(text: text, isUser: true);
    chatService.addMessage(state.currentChat!.id, userMsg);

    var updatedChat = chatService.getChat(state.currentChat!.id);
    emit(state.copyWith(currentChat: updatedChat));

    // رسالة AI جديدة
    final aiMsg = ChatMessage(text: '', isUser: false);
    chatService.addMessage(updatedChat!.id, aiMsg);

    updatedChat = chatService.getChat(updatedChat.id);
    emit(state.copyWith(currentChat: updatedChat));

    // Streaming من AI
    await for (var chunk in repo.grokStream(text)) {
      aiMsg.text += chunk;
      updatedChat = chatService.getChat(updatedChat!.id);
      emit(state.copyWith(currentChat: updatedChat));
    }

    // تحديث النسخة النهائية للرسالة
    chatService.updateMessage(updatedChat!.id, aiMsg);
    updatedChat = chatService.getChat(updatedChat.id);
    emit(state.copyWith(currentChat: updatedChat, isLoading: false));
  }

  // حذف شات
  void deleteChat(String chatId) {
    chatService.deleteChat(chatId);

    if (state.currentChat?.id == chatId) {
      emit(state.copyWith(currentChat: null));
    }
  }

  // تعديل اسم الشات
  void updateChatTitle(String chatId, String newTitle) {
    chatService.updateChatTitle(chatId, newTitle);
    if (state.currentChat?.id == chatId) {
      final updatedChat = chatService.getChat(chatId);
      emit(state.copyWith(currentChat: updatedChat));
    }
  }
}

