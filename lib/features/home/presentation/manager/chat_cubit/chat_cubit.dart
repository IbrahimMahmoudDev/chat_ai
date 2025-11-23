
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

    // خزّن آخر محادثة مفتوحة
    chatService.lastOpenedChatId = chatId;
  }


  // إرسال رسالة المستخدم + AI
  Future<void> sendMessage(String text) async {
    if (state.currentChat == null) return;

    emit(state.copyWith(isLoading: true));

    // 1. رسالة المستخدم
    final userMsg = ChatMessage(text: text, isUser: true);
    chatService.addMessage(state.currentChat!.id, userMsg);

    // 2. رسالة AI فارغة في البداية
    final aiMsg = ChatMessage(text: '', isUser: false);
    chatService.addMessage(state.currentChat!.id, aiMsg);

    // إعادة تحميل الشات مرة واحدة بعد إضافة الرسايل
    final updatedChat = chatService.getChat(state.currentChat!.id)!;
    emit(state.copyWith(currentChat: updatedChat));

    // 3. Streaming
    try {
      await for (var chunk in repo.grokStream(text)) {
        aiMsg.text += chunk;

        // بدل ما نروح للـ Hive كل مرة، نعدل الرسالة في الذاكرة بس ونحدّث الـ state
        final messages = updatedChat.messages;
        final aiIndex = messages.lastIndexWhere((m) => !m.isUser);
        if (aiIndex != -1) {
          messages[aiIndex] = aiMsg; // نعدل الرسالة في القايمة
        }

        emit(state.copyWith(
          currentChat: updatedChat.copyWith(messages: messages),
        ));
      }
    } catch (e) {
      print("Error in stream: $e");
    }

    // تحديث نهائي في Hive (مرة واحدة بس في النهاية)
    chatService.updateMessage(state.currentChat!.id, aiMsg);

    emit(state.copyWith(isLoading: false));
  }

  // حذف شات
  void deleteCurrentAndStartNew() {
    final currentId = state.currentChat?.id;

    if (currentId != null) {
      chatService.deleteChat(currentId);
    }

    // بعد الحذف، nullify currentChat → لإفراغ الـ UI
    emit(state.copyWith(currentChat: null, isLoading: false));

    // جلب كل الشاتات الموجودة
    final remainingChats = chatService.getAllChats();

    if (remainingChats.isNotEmpty) {
      // لو فيه شات تاني → افتح أول واحد
      emit(state.copyWith(currentChat: remainingChats.first, isLoading: false));
    }
  }




  // تعديل اسم الشات
  void updateChatTitle(String chatId, String newTitle) {
    chatService.updateChatTitle(chatId, newTitle);

    if (state.currentChat?.id == chatId) {
      final updated = chatService.getChat(chatId);
      emit(state.copyWith(currentChat: updated));
    }
  }

}

