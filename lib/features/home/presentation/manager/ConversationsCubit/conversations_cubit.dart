import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/chat_services.dart';
import '../../../data/models/chat_model.dart';

class ConversationsCubit extends Cubit<List<ChatModel>> {
  final ChatService chatService;

  ConversationsCubit(this.chatService) : super([]) {
    loadAllChats();
  }

  void loadAllChats() {
    emit(chatService.getAllChats());
  }

  String createNewChat({String? title}) {
    final id = chatService.createNewChat(title: title ?? 'New Chat');
    loadAllChats();
    return id;
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
