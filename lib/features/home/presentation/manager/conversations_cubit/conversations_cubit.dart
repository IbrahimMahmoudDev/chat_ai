import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/chat_services.dart';
import '../../../data/models/chat_model.dart';

class ConversationsCubit extends Cubit<List<ChatModel>> {
  final ChatService chatService;

  ConversationsCubit(this.chatService) : super([]) {
    loadAllChats();
  }

  void loadAllChats() {
    final chats = chatService.getAllChats();
    chats.sort((a, b) => b.createdAt.compareTo(a.createdAt)); // الأحدث فوق
    emit(chats);
  }

  String createNewChat({String? title}) {
    ChatModel newChat = chatService.createNewChat(title: title ?? 'New Chat');
    loadAllChats();
    return newChat.id;
  }

  void deleteChat(String chatId) {
    chatService.deleteChat(chatId);
    loadAllChats();
    if (chatId == chatService.lastOpenedChatId) {

    }
  }

  void updateChatTitle(String chatId, String newTitle) {
    chatService.updateChatTitle(chatId, newTitle);
    loadAllChats();
  }
}
