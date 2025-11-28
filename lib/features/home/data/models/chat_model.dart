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

  @HiveField(3)
  final DateTime createdAt;

  ChatModel({
    required this.id,
    required this.title,
    required this.messages,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  ChatModel copyWith({
    String? id,
    String? title,
    List<ChatMessage>? messages,
  }) {
    return ChatModel(
      id: id ?? this.id,
      title: title ?? this.title,
      messages: messages ?? this.messages,
      createdAt: createdAt,
    );
  }
}
