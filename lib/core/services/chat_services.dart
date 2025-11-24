import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../features/home/data/models/chat_message.dart';
import '../../features/home/data/models/chat_model.dart';

class ChatService {
  final box = Hive.box<ChatModel>('chats');
  String? lastOpenedChatId;

  // إنشاء شات جديد باسم مخصص
  ChatModel createNewChat({String? title}) {
    final id = const Uuid().v4();
    final chatTitle = title ?? "New Chat";
    final chat = ChatModel(id: id, title: chatTitle, messages: []);
    box.put(id, chat);
    return chat; // دلوقتي بترجع ChatModel بدل String
  }


  // إضافة رسالة
  void addMessage(String chatId, ChatMessage msg) {
    final chat = box.get(chatId);
    if (chat == null) return;
    chat.messages.add(msg);
    box.put(chatId, chat);
  }

  // تحديث آخر رسالة AI فقط
  void updateMessage(String chatId, ChatMessage msg) {
    final chat = box.get(chatId);
    if (chat == null) return;

    final aiIndex = chat.messages.lastIndexWhere((m) => !m.isUser);
    if (aiIndex != -1) {
      chat.messages[aiIndex] = msg;
      box.put(chatId, chat);
    }
  }

  // الحصول على شات (آمن مع null)
  ChatModel? getChat(String chatId) => box.get(chatId);

  // كل الشاتات
  List<ChatModel> getAllChats() => box.values.toList();

  // حذف شات
  void deleteChat(String chatId) {
    box.delete(chatId);
  }

  // تعديل اسم الشات
  void updateChatTitle(String chatId, String newTitle) {
    final chat = box.get(chatId);
    if (chat == null) return;
    chat.title = newTitle;
    box.put(chatId, chat);
  }
}
