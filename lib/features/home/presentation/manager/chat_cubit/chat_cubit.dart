import 'package:chat_ai/features/authiciation/presentation/views/widgets/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/chat_services.dart';
import '../../../../../core/services/git_it_services.dart';
import '../../../../../core/services/netwok_services.dart';
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
  Future<void> sendMessage(String text, BuildContext context) async {
    if (state.currentChat == null) return;

    // 🔴 1) Check Internet FIRST
    final hasInternet = await getIt<NetworkService>().hasInternet();
    if (!hasInternet) {
      showSnackBar(context,
          "Please check your network and try again.",
          Colors.red);
      return; // ← stop here
    }

    emit(state.copyWith(isLoading: true));

    // 🟢 2) Add user message ONLY if internet is available
    final userMsg = ChatMessage(text: text, isUser: true);
    chatService.addMessage(state.currentChat!.id, userMsg);

    final aiMsg = ChatMessage(text: '', isUser: false);
    chatService.addMessage(state.currentChat!.id, aiMsg);

    final updatedChat = chatService.getChat(state.currentChat!.id)!;
    emit(state.copyWith(currentChat: updatedChat));

    // 🔵 3) Streaming
    try {
      await for (var chunk in repo.grokStream(text)) {
        aiMsg.text += chunk;

        final messages = updatedChat.messages;
        final aiIndex = messages.lastIndexWhere((m) => !m.isUser);
        if (aiIndex != -1) messages[aiIndex] = aiMsg;

        emit(state.copyWith(
            currentChat: updatedChat.copyWith(messages: messages)));
      }
    } catch (e) {
      // 🔴 لو حصل Error في منتصف ال-stream → Snackbar فقط
      showSnackBar(context, "Connection issue Please try again", Colors.red);

      emit(state.copyWith(isLoading: false));
      return;
    }

    // Save final message
    chatService.updateMessage(state.currentChat!.id, aiMsg);

    emit(state.copyWith(isLoading: false));
  }


  // حذف شات
  void deleteCurrentAndStartNew() {
    final currentId = state.currentChat?.id;

    if (currentId != null) {
      // حذف الشات الحالي من Hive
      chatService.deleteChat(currentId);
    }

    // جلب كل الشاتات الموجودة بعد الحذف
    final remainingChats = chatService.getAllChats();

    if (remainingChats.isNotEmpty) {
      // لو فيه شات تاني → افتح أول واحد
      emit(state.copyWith(currentChat: remainingChats.first, isLoading: false));
    } else {
      // لو مفيش شات → فرغ الـ UI وأظهر empty state
      emit(const ChatState(currentChat: null, isLoading: false));
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
