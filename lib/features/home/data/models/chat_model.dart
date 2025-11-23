import 'package:hive/hive.dart';
import 'chat_message.dart';

part 'chat_model.g.dart';

@HiveType(typeId: 2)
class ChatModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  List<ChatMessage> messages;

  ChatModel({
    required this.id,
    required this.title,
    required this.messages,
  });
}
